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
	
	var youtubeTrailerId : String!
	
	
	
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
	
	

	
	
	@IBAction func playTrailer(_ sender: Any) {
		
		print("Play \(youtubeTrailerId)")
		
	}
	
	
	

	
	
	
	
	
}
extension UIViewController{
	
	
	
}
