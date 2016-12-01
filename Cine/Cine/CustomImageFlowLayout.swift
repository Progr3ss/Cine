//
//  CustomImageFlowLayout.swift
//  Cine
//
//  Created by martin chibwe on 11/19/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit

class CustomImageFlowLayout: UICollectionViewFlowLayout {
	
	override init() {
		super.init()
		setupLayout()
		//		setItemsInRow(3)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupLayout()
	}
	
	override var itemSize: CGSize {
		set {
			
		}
		get {
			let numberOfColumns: CGFloat = 2
			
			let itemWidth = (self.collectionView!.frame.width - (numberOfColumns - 1)) / numberOfColumns
			
			print("ITemWidth \(itemWidth)")
			
			//			let itemWidth = 140.0
			return CGSize(width: itemWidth, height: itemWidth)
		}
	}
	
	func setupLayout() {
		minimumInteritemSpacing = 1
		minimumLineSpacing = 1
		scrollDirection = .vertical
	}
	
	
	
}
