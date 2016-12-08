//
//  HorizentalView.swift
//  Swiffshot
//
//  Created by martin chibwe on 12/3/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
var playerItem:AVPlayerItem?
class HorizentalView: UIViewController,  AVCaptureFileOutputRecordingDelegate  {
	
	
	@IBOutlet weak var cameraView: UIView!
	@IBOutlet weak var cameraButton: UIButton!
	@IBOutlet weak var tableView: UITableView!
	
	
	let captureSession = AVCaptureSession()
	var currentDevice:AVCaptureDevice?
	var videoFileOutput:AVCaptureMovieFileOutput?
	var cameraPreviewLayer:AVCaptureVideoPreviewLayer?
	var player: AVPlayer!
	var urlVideo : URL!
	
	var isRecording = false
	override func viewDidLoad() {
		super.viewDidLoad()
		print("Transfer Video \(urlVideo)")
		
		// Preset the session for taking photo in full resolution
		captureSession.sessionPreset = AVCaptureSessionPresetHigh
		
		// Get the available devices that is capable of taking video
		let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as! [AVCaptureDevice]
		
		// Get the back-facing camera for taking videos
		for device in devices {
			if device.position == AVCaptureDevicePosition.back {
				currentDevice = device
			}
		}
		
		let captureDeviceInput:AVCaptureDeviceInput
		do {
			captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice)
		} catch {
			print(error)
			return
		}
		
		// Configure the session with the output for capturing video
		videoFileOutput = AVCaptureMovieFileOutput()
		
		// Configure the session with the input and the output devices
		captureSession.addInput(captureDeviceInput)
		captureSession.addOutput(videoFileOutput)
		
		// Provide a camera preview
		cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
		cameraView.layer.addSublayer(cameraPreviewLayer!)
		cameraPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
		cameraPreviewLayer?.frame = cameraView.layer.frame
		
		captureSession.startRunning()
	}
	
	
	func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
		
		if error != nil {
			print(error)
			return
		}
		
		performSegue(withIdentifier: "playVideo", sender: outputFileURL)
	}
	
	// MARK: - Segue methods
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "playVideo" {
			let videoPlayerViewController = segue.destination as! AVPlayerViewController
			let videoFileURL = sender as! URL
			videoPlayerViewController.player = AVPlayer(url: videoFileURL)
		}
	}
	
	
	
	@IBAction func cameraButtonPressed(_ sender: Any) {
		
		if !isRecording {
			isRecording = true
			
			UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: { () -> Void in
				self.cameraButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
			}, completion: nil)
			
			let outputPath = NSTemporaryDirectory() + "output.mov"
			let outputFileURL = URL(fileURLWithPath: outputPath)
			videoFileOutput?.startRecording(toOutputFileURL: outputFileURL, recordingDelegate: self)
		} else {
			
			isRecording = false
			
			UIView.animate(withDuration: 0.5, delay: 1.0, options: [], animations: { () -> Void in
				self.cameraButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			}, completion: nil)
			cameraButton.layer.removeAllAnimations()
			videoFileOutput?.stopRecording()
		}
	}
	
}


extension HorizentalView: UITableViewDataSource{
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Filters"
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CategoryCell
		
		
		
		
		return cell!
	}
	
}


extension CategoryCell: UICollectionViewDataSource{
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 12
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath)
		cell.backgroundColor = UIColor.green
//		self.urlVideo = urlVideo
//		print(urlVideo)
//		playerItem  AVPlayerItem(url: urlVideo)
	
		
		
		
		return cell
		
	}
	
	
	
	
}

extension CategoryCell : UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let itemsPerRow:CGFloat = 4
		let hardCodedPadding:CGFloat = 5
		let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
		let itemHeight = collectionView.bounds.height - (3 * hardCodedPadding)
		return CGSize(width: itemWidth, height: itemHeight)
	}
	
}

