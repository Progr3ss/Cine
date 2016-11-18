//
//  MoviesNowPlayingViewController.swift
//  Cine
//
//  Created by martin chibwe on 11/18/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit

class MoviesNowPlayingViewController: UIViewController {
	
	var movies: [TMDBMovie] = [TMDBMovie]()
	var pageNumber = 1
//	let scrollView : UIScrollView!
	@IBOutlet weak var moviesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		print("pageNumber \(pageNumber)")
		
//		moviesCollectionView.delegate = self
//		moviesCollectionView.dataSource = self
//		scrollView.delegate = self
//		UIScrollView.delegate = self
		
//		let 

        // Do any additional setup after loading the view.
    }

	
	override func viewWillAppear(_ animated: Bool) {
		
		super.viewWillAppear(animated)
		
		
		print("pageNumberViewWIll \(pageNumber)")
		TMDBClient.sharedInstance().getNowPlayingMovies(page: pageNumber, {(movies, error) in
			
			if let movies  = movies{
				self.movies = movies
				
				performUIUpdatesOnMain {
					
					self.moviesCollectionView.reloadData()
			
				}
			}else{
				print(error)
			}
		
		
		})
	}
	

	
//	func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
//		
//		delegate?.scrollViewDidScrollToTop?(scrollView)
//		
//		print("Scrollview \(scrollView.scrollsToTop)")
////		if scrollView.contentOffset.y == 0{
////			print("Ended")
////			pageNumber  += 1
////			
////		}
//		
////		pageNumber += 1
////		
////		print("pageNumber \(pageNumber)")
//		
//	}
//	
//	scrollView)
	

}


extension MoviesNowPlayingViewController: UICollectionViewDataSource{
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cellResueIdentifier = "NowPlayingCell"
		let movie = movies[(indexPath as NSIndexPath).row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellResueIdentifier, for: indexPath) as! NowPlayingCellCollectionViewCell
		
		
//		collectionView.isScrollEnabled = true
		
	
//		if indexPath.row == 19 {
//			pageNumber += 1
//		}
		
//		 self.moviesCollectionView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true) 
		
		
//		moviesCollectionView.indexPath.last
		
		let a = moviesCollectionView.numberOfSections - 1
		if a == indexPath.row {
			print("Yah")
			
			pageNumber  += 1
		}
//		if a {
//			pageNumber += 1
//			print("Gread")
//		}
		
		
		var item = self.collectionView(self.moviesCollectionView!, numberOfItemsInSection: 0) - 1
		var lastItemIndex = NSIndexPath(item: item, section: 0)
		
		
		if indexPath.row == movies.count {
			print("Last Row")
		}
		
//		if 	self.moviesCollectionView?.scrollToItem(at: lastItemIndex as IndexPath, at: UICollectionViewScrollPosition.bottom, animated:false) {
//			
//		}
//		
//		var lastItemIndex = NSIndexPath(forItem: item, inSection: 0)
		
//		self.moviesCollectionView?.scrollToItem(at: lastItemIndex as IndexPath, at: UICollectionViewScrollPosition.bottom, animated:false)
//		
		
//		self.collectionView?.scrollToItemAtIndexPath(lastItemIndex, atScrollPosition: UICollectionViewScrollPosition.Top, animated: false)
		
		
//		cell.configureCell()
		if let posterPath = movie.posterPath {
			let _ = TMDBClient.sharedInstance().taskForGETImage(TMDBClient.PosterSizes.RowPoster, filePath: posterPath, completionHandlerForImage: { (imageData, error) in
				if let image = UIImage(data: imageData!) {
					performUIUpdatesOnMain {
					
						cell.configureCell(data: imageData!)
					}
				} else {
					print(error)
				}
			})
		}
		
		
		
		
		return cell
		
	}
	
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
//		print("Movies \(movies.count)")
//		
//		if (indexPath == movies.count){
//			print("Last Row")
//			
//		}
		return movies.count
	}
	
}


extension  MoviesNowPlayingViewController: UIScrollViewDelegate{
	
	
	func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
		scrollView.delegate = self
		
		print("End")
		
		
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		
		if(velocity.y>0){
			print("dragging Up")
		}else{
			NSLog("dragging Down");
		}
	}
	

	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
		print("Scrolling")
		
		
		var bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
		
		if bottomEdge >= scrollView.contentSize.height{
			
			print("Bottom")
			
			pageNumber += 1
			
			
			
//			TMDBClient.sharedInstance().getNowPlayingMovies(page: pageNumber, {(movies, error) in
//				
//				if let movies  = movies{
//					self.movies = movies
//					
//					performUIUpdatesOnMain {
//						
//						self.moviesCollectionView.reloadData()
//						
//					}
//				}else{
//					print(error)
//				}
//				
//				
//			})
		}
//			
//			performUIUpdatesOnMain {
////				self.moviesCollectionView.reloadData()
//				
//				
//			}
//			moviesCollectionView.reloadData()
			
		}
//		self.collectionView.isScrollEnabled = true
//		print("yes")
		
//		scrollView.delegate = self
//		let foregroundHeight = foreground.contentSize.height - foreground.bounds.height
//		let percentageScroll = foreground.contentOffset.y / foregroundHeight
//		let backgroundHeight = background.contentSize.height - background.bounds.height
//		
//		background.contentOffset = CGPoint(x: 0, y: backgroundHeight * percentageScroll)
	
	
}











