//
//  MoviesNowPlayingViewController.swift
//  Cine
//
//  Created by martin chibwe on 11/18/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit

class MoviesNowPlayingViewController: UIViewController {
	
	var appDelegate: AppDelegate!
	var movies: [TMDBMovie] = [TMDBMovie]()
	var trailers: [TMDBTrailers] = [TMDBTrailers]()
	let cellResueIdentifier = "NowPlayingCell"
	
	var url : URL!
//	var movieId: Int?
	var pageNumber = 1
	//	let scrollView : UIScrollView!
	@IBOutlet weak var moviesCollectionView: UICollectionView!
	var collectionViewLayout: CustomImageFlowLayout!
	override func viewDidLoad() {
		super.viewDidLoad()
		appDelegate = UIApplication.shared.delegate as! AppDelegate
		collectionViewLayout = CustomImageFlowLayout()
		
		moviesCollectionView.collectionViewLayout = collectionViewLayout
		
		
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		
		super.viewWillAppear(animated)
		
		
		TMDBClient.sharedInstance().getNowPlayingMovies(page: pageNumber, {(movies, error) in
			
			if let movies  = movies{
				
				self.movies += movies
				
				
				performUIUpdatesOnMain {
					
					self.moviesCollectionView.reloadData()
					
				}
			}else{
				print(error)
			}
			
			
		})
		
		
//		TMDBClient.sharedInstance().getMovieVideos(movieId: <#T##Int#>, <#T##completionHandlerForNowPlaying: ([TMDBTrailers]?, NSError?) -> Void##([TMDBTrailers]?, NSError?) -> Void#>)
		
		
		
	}
	
	
	
}

extension MoviesNowPlayingViewController: UICollectionViewDataSource{
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//		let cellResueIdentifier = "NowPlayingCell"
		let movie = movies[(indexPath as NSIndexPath).row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellResueIdentifier, for: indexPath) as! NowPlayingCellCollectionViewCell
		
		
		var item = self.collectionView(self.moviesCollectionView!, numberOfItemsInSection: 0) - 1
		var lastItemIndex = NSIndexPath(item: item, section: 0)
		
		
		
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
		
		
		TMDBClient.sharedInstance().getMovieVideos(movieId: movie.id, {(movies, error) in
			
			if let movies  = movies{
				
				performUIUpdatesOnMain {
					
//					let url = URL(string: "https://www.youtube.com/watch?v=\((movies[0].key))")
					
					print("NowPlayingURLURL \(movie.id)")
					
					
					cell.youtubeTrailerId = movies[0].key
//					cell.url = self.url
//					cell.url
					
				}
			}else{
				print(error)
			}
			
			
		})

		
		
		
		
		return cell
		
	}
	
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		
		print("Movies \(movies.count)")
		return movies.count
	}
	
	
	
}

//extension  MoviesNowPlayingViewController: UICollectionViewDelegate {
//	
//	
////	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////		let movie = movies[(indexPath as NSIndexPath).row]
////		
////		
//////		if let movieId = movie.id {
//////			
//////		}
////		
////		
////		let movieId = movie.id
//////		var movieId: Int? = movie.id
////		
////		
////		
////		
////		print("MovieId  \(movieId)")
////		
////		
//////		self.appDelegate.movie_ID = movieId
////		
//		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellResueIdentifier, for: indexPath) as! NowPlayingCellCollectionViewCell
//		
////		TMDBClient.sharedInstance().getMovieVideos(movieId: movieId, {(movies, error) in
////			
////			if let movies  = movies{
////
////				
////				performUIUpdatesOnMain {
////					
////
////					self.url = URL(string: "https://www.youtube.com/watch?v=\((movies[0].key))")
////					
////					print("NowPlayingURLURL \(self.url)")
////					
////					self.performSegue(withIdentifier: "movieDetails", sender: self)
////
////				}
////			}else{
////				print(error)
////			}
////			
////			
////		})
////	}
//	
//
//	
////	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////		
////		print("Sender URl \(url)")
////		print("identifier = \(segue.identifier)")
////		
////		
////		if  segue.identifier == "movieDetails"  {
////			
////			let destincationVC = segue.destination as! HorizentalView
////			
////			print("Destination URl \(url)")
////			destincationVC.urlVideo = url
////				
////				
////				
////	
////			
////		
////		
////		}
////	}
//}


//https://api.themoviedb.org/3/movie/343611/videos?api_key=2007a6ba55005dd305c31f4d13354605&language=en-US

extension  MoviesNowPlayingViewController: UIScrollViewDelegate{
	

	

	
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
		
		
		var bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
		
		if bottomEdge >= scrollView.contentSize.height{
			
			
			pageNumber += 1
			
			TMDBClient.sharedInstance().getNowPlayingMovies(page: pageNumber, {(movies, error) in
				
				if let movies  = movies{
					self.movies += movies
					
					performUIUpdatesOnMain {
						
						self.moviesCollectionView.reloadData()
						
					}
				}else{
					print(error)
				}
				
				
			})
		}
		
		
	}
	
}











