//
//  NowPlayingCellCollectionViewCell.swift
//  Cine
//
//  Created by martin chibwe on 11/18/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class NowPlayingCellCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var artworkImageView: UIImageView!
	var playerController = AVPlayerViewController()
	var url : URL!
	
	
	
	func configureCell(data:Data)  {
		
		
		//		let data = try? Data(contentsOf: imageURL)
		if let image = UIImage(data: data){
			
			if image == nil {
				self.artworkImageView.image = UIImage(named: "Film")
			}
			else{
				self.artworkImageView.image = image
			}
			
		}
		
		
	}
	
	
	//	func videoURL(key: String) -> URL{
	//
	//
	//		let url = URL(string: "https://www.youtube.com/watch?v=\(key)")
	////		URLSession.shared.dataTask(with: url!, completionHandler: {
	////			(data, response, error) in
	////			if(error != nil){
	////				print("error")
	////			}else{
	////
	////			}
	////		}).resume()
	//
	//		return url!
	//	}
	//
	//	func playVideo(url: NSURL){
	//		let player = AVPlayer(url: url as URL)
	//		let playerController = AVPlayerViewController()
	//
	//		playerController.player = player
	////		self.addChildViewController(playerController)
	////		self.view.addSubview(playerController.view)
	////		playerController.view.frame = self.view.frame
	//
	//		player.play()
	//	}
	//
	
	
		func videoURL(url:URL) {
	
	
		
	
	
//			print("CellURl \(url)")
	
		}
	
	
	
	
	
	@IBAction func playVideoButton(_ sender: Any) {
		
		print("URLCell \(url)")
//		let player = AVPlayer(url: url as URL)
//		playerController = AVPlayerViewController()
//		playerController.player = player
//		player.play()
		

			
//		}
		
		
//		func videoURL(url:URL) {
//			
			
//			let player = AVPlayer(url: url as URL)
//			playerController = AVPlayerViewController()
//			playerController.player = player
//			player.play()
			
//
//		}
		
//		if let urlString = URL(string : "") {
//			
//		}
		
		//		videoURL(url: <#T##URL#>)
		
//		let player = AVPlayer(url: url as URL)
//		playerController = AVPlayerViewController()
//		playerController.player = player
//		player.play()
//		
//		
		
//		print("StringURL \(url)")
		
	}
	
	
	
	
	
	
}
extension UIViewController{
	
	
	
}
