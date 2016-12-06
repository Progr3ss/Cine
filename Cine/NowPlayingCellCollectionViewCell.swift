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
class NowPlayingCellCollectionViewCell: UICollectionViewCell, AVPlayerViewControllerDelegate {
	
	@IBOutlet weak var playButtonLabel: UIButton!
	@IBOutlet weak var artworkImageView: UIImageView!
	var playerController = AVPlayerViewController()
	var url: URL!
//	var button:UIButton!
	
	
//	override init(frame: CGRect) {
//		
//		super.init(frame:frame)
//		
//		playButtonLabel.isUserInteractionEnabled = true
//		playButtonLabel.isEnabled = true
//		playButtonLabel.addTarget(self, action:Selector(("pressed")), for: .primaryActionTriggered)
//		self.addSubview(playButtonLabel)
//		
//		
//	}
//	
//	required init?(coder aDecoder: NSCoder) {
//		super.init(coder: aDecoder)
////		fatalError("init(coder:) has not been implemented")
//	}
//	
	
	
//	required init?(coder aDecoder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
	
//	func pressed(sender: UIButton!) {
//		print("button pressed!")
//	}
//	
//
	func configureCell(data:Data)  {
		
		
		if let image = UIImage(data: data){
			
			if image == nil {
				self.artworkImageView.image = UIImage(named: "Film")
			}
			else{
				self.artworkImageView.image = image
				

			}
			
		}
		
		
	}
	
	
	
	
	
	
	
	
	@IBAction func playVideoButton(_ sender: Any) {
		

			
		}
		

}

//extension UIButton {
//	
//	open override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//		
//		if self.superview is NowPlayingCellCollectionViewCell {
//			if context.nextFocusedView == self {
//				print("Focused View")
//			}else{
//				print("Not Focused")
//			}
//		}
//		
//		
//	}
//
//}

