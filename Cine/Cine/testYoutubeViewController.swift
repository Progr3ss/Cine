//
//  testYoutubeViewController.swift
//  Cine
//
//  Created by martin chibwe on 12/16/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit
//#import "YTPlayerView.h"

class testYoutubeViewController: UIViewController, YTPlayerViewDelegate {
	
	

	@IBOutlet weak var playerView: YTPlayerView!
	

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.playerView.delegate = self
		var playerVars = ["playsinline": 1]
		playerView.load(withVideoId: "M7lc1UVf-VE", playerVars: playerVars)
		
		//playerView.load(withVideoId: "M7lc1UVf-VE")
		//playerView.playVideo()

        // Do any additional setup after loading the view.
    }
	
	override func viewDidAppear(_ animated: Bool) {
		playerView.playVideo()
	}
	
	
	@IBAction func playVideo(_ sender: Any) {
		
		playerView.playVideo()
	}

	@IBAction func stopVideo(_ sender: Any) {
		
		playerView.stopVideo()
	}

	func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
		
		switch state {
		case .playing:
			
			print("Stared Playback")
			
		case .queued:
			playerView.playVideo()
			print("Stoped playing")
		default:
			break
		}
	}
	
	func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
		
		playerView.playVideo()
		playerView.seek(toSeconds: 0.0, allowSeekAhead: true)
		print("Playing")
		playerView.videoEmbedCode()
		
		
	}
	

	
	
	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
