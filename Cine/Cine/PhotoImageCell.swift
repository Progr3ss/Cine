//
//  PhotoImageCell.swift
//  Cine
//
//  Created by martin chibwe on 10/17/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit

class PhotoImageCell: UICollectionViewCell {
	
	var downloadTask: URLSessionDownloadTask?
	
	@IBOutlet weak var artworkImageView: UIImageView!

	
	func conigureCell(for imageURL: URL){
		
		//artworkImageView.image = imageURL
		
		
		//artworkImageView.image = UIImage(named: "film_64")
		
		
		//performUIUpdatesOnMain {
		
		
		let data = try? Data(contentsOf: imageURL)
		
		performUIUpdatesOnMain {
			
			if let image = UIImage(data: data!){
				
				if image == nil {
					self.artworkImageView.image = UIImage(named: "film_64")
				}
				else{
					self.artworkImageView.image = image
				}
				
				
			}
			
			
			
		}
		
		
		
		
			
			
		
	
		
		//	let data = try ? Data(contentsOf: imageURL){
				
		//	}
		//artworkImageView.image = UIImage(data: imageURL)
		//}
		//print("DOWNLOADTASK \(downloadTask)")
		
//		 downloadTask = artworkImageView.loadImage(url: imageURL)
//		artworkImageView.image = UIImage(named: "Placeholdeer")
//		
//		if let medidumURL = URL(string: ""){
//			
//			 downloadTask = artworkImageView.loadImage(url: medidumURL)
//		}
		
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		downloadTask?.cancel()
		downloadTask = nil
	}
}
