//
//  NowPlayingCellCollectionViewCell.swift
//  Cine
//
//  Created by martin chibwe on 11/18/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit

class NowPlayingCellCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var artworkImageView: UIImageView!
	
	
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
	
    
}
