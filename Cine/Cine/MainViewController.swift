//
//  MainViewController.swift
//  Cine
//
//  Created by martin chibwe on 10/11/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
	// MARK: Properties
	
	@IBOutlet weak var collectionView: UICollectionView!
//	@IBOutlet weak var segmentedControl: UISegmentedControl!
	let segmentedControl = SegmentedControl(items: ["NOW PLAYING", "UPCOMING", "POPULAR",])
	
	var appDelegate: AppDelegate!
	
	var movies: [TMDBMovie] = [TMDBMovie]()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		
//		
//		view.addSubview(segmentedControl)
//		
//		segmentedControl.backgroundColor = #colorLiteral(red: 0.7683569193, green: 0.9300123453, blue: 0.9995251894, alpha: 1)
//		segmentedControl.translatesAutoresizingMaskIntoConstraints = false
//		segmentedControl.selectionIndicatorPosition = .Bottom
//		segmentedControl.selectionIndicatorColor = #colorLiteral(red: 0.1142767668, green: 0.3181744218, blue: 0.4912756383, alpha: 1)
//		segmentedControl.titleTextAttributes = [
//			NSForegroundColorAttributeName : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
//			NSFontAttributeName : UIFont.systemFont(ofSize: 17)
//		]
//		
//		segmentedControl.selectedTitleTextAttributes = [
//			NSForegroundColorAttributeName : #colorLiteral(red: 0.05439098924, green: 0.1344551742, blue: 0.1884709597, alpha: 1),
//			NSFontAttributeName : UIFont.boldSystemFont(ofSize: 17)
//		]
//		segmentedControl.indexChangedHandler = { index in
//			print(index)
//			//            print(self.segmentedControl.selectedSegmentIndex)
//			//            self.segmentedControl.selectedSegmentIndex = 1
//		}
//		
//		NSLayoutConstraint.activate(
//			[segmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor),
//			 segmentedControl.heightAnchor.constraint(equalToConstant: 30),
//			 segmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor),
//			 segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)]
//			
//		)
		appDelegate = UIApplication.shared.delegate as! AppDelegate
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
		
//		let methodParmeters = [
//			Constants.TMDBParameterKeys.ApiKey: Constants.TMDBParameterValues.ApiKey,
//			Constants.TMDBResponseKeys.Page: 1
//			
//		]
		
		
    }
	
	
	override func viewWillAppear(_ animated: Bool) {
		
		let request = NSMutableURLRequest(url: appDelegate.tmdbURLFromParameters(parameters: methodParemters(page: 1), withPathExtension: "/movie/now_playing") as URL)
		
		let task = appDelegate.sharedSession.dataTask(with: request as URLRequest){(data, response, error) in
			
			
			func displayError(error: String){
				
				print(error)
				performUIUpdatesOnMain {
					print("Error Loading ... \(error)")
					
				}
				
			}
			
			/*Guard: were there any error ?*/
			guard(error == nil) else{
				displayError(error: "There was an error with your request \(error)")
				return
			}
			
			/*Guard: Did we get a sucessful 2xx response*/
			guard let statusCode = (response as? HTTPURLResponse)?.statusCode , statusCode >= 200 && statusCode <= 299 else{
				
				displayError(error: "Your request returned a status code other than 2xx! in UserId")
				
				return
			}
			
			/*Guard: Was ther any data returned */
			guard let data = data else{
				displayError(error: "No data was returned by the request")
				
				return
			}
			
			/*Parse the data!*/
			let parsedResult : AnyObject!
			
			do{
				parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
				
			}catch {
				displayError(error: "Could not parse the data as JSON: \(data)")
				return
			}
			
			
			/*Guard: Did TheMovieDataBase return an error */
			if let _ = parsedResult[Constants.TMDBResponseKeys.StatusCode] as? Int {
				displayError(error: "TheMovieDB returned an error. See The \(Constants.TMDBResponseKeys.StatusCode) in \(parsedResult)")
				
				return
			}
			print(" parsedResultUerID = \(parsedResult)")
			
			
			
			/* GUARD: Is the "results" key in parsedResult? */
			guard let results = parsedResult[Constants.TMDBResponseKeys.Results] as? [[String:AnyObject]] else {
				print("Cannot find key '\(Constants.TMDBResponseKeys.Results)' in \(parsedResult)")
				return
			}
			
			//			print(" Results = \(results)")
			//			self.movies = TMDBMovie.movieFromResults(results: parsedResult as! [[String : AnyObject]])
			self.movies = TMDBMovie.movieFromResults(results: results)
			
			
			performUIUpdatesOnMain {
				print("Loading Data ")
//				self.collectionView.reloadData()
			}
			
			
			self.collectionView.reloadData()
			print("Self.movies \(self.movies)")
			
			/*Guard: Is the Guest Session ID in parsedResults*/
			//			guard let overview = parsedResult[Constants.TMDBResponseKeys.Overview] as? String else {
			//				displayError(error: "Cannot find key Overview in \(parsedResult)")
			//				return
			//
			//			}
			//			self.movies = TMDBMovie.movieFromResults(results: results)
			
			//			print("OverViwe \(self.movies)")
			
			
			
			
			
			
		}

		task.resume()
//		print(movies)
	}//end View
	
	func methodParemters(page: Int) -> [String: AnyObject] {
		
		let methodParmeter = [
			Constants.TMDBParameterKeys.ApiKey: Constants.TMDBParameterValues.ApiKey,
			Constants.TMDBResponseKeys.Page: page
			
		] as [String : Any]
		
		return methodParmeter as [String : AnyObject]
	}

 

}


extension MainViewController: UICollectionViewDataSource{
//	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		
//		print("Moive Index \(movies[indexPath.row])")
		let movie = self.movies[indexPath.row]
		print("Moives \(movie) and Index \(movies[indexPath.row])")
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoImageCell
		
		cell.artworkImageView.image = UIImage(named: "Film Icon")
		
		
		

		if let posterPath = movie.posterPath {
			
			print("iffPosterPath \(movie.posterPath)")
			/* 2. Build the URL */
			let baseURL = NSURL(string: appDelegate.config.baseImageURLString)!
			
//			let url = baseURL.URLByAppendingPathComponent("w154")!.URLByAppendingPathComponent(posterPath)
			let url = baseURL.appendingPathComponent("w154")!.appendingPathComponent(posterPath)
			
			
		
			print("ifstatement URL \(url)")
			
			cell.conigureCell(for: url)
			/* 3. Configure the request */

			
		}

		
	
		return cell
	}
	
	/*
	let request = NSURLRequest(url: url)
	
	/* 4. Make the request */
	let task = appDelegate.sharedSession.dataTask(with: request as URLRequest) { (data, response, error) in
	
	
	/* GUARD: Was there an error? */
	guard (error == nil) else {
	print("There was an error with your request: \(error)")
	return
	}
	
	/* GUARD: Did we get a successful 2XX response? */
	guard let statusCode = (response as? HTTPURLResponse)?.statusCode , statusCode >= 200 && statusCode <= 299 else {
	print("Your request returned a status code other than 2xx!")
	return
	}
	
	/* GUARD: Was there any data returned? */
	guard let data = data else {
	print("No data was returned by the request!")
	return
	}
	
	/* 5. Parse the data */
	// No need, the data is already raw image data.
	
	/* 6. Use the data! */
	
	print("Data = \(data)")
	if let image = UIImage(data: data) {
	
	
	//performUIUpdatesOnMain {
	
	//	cell.conigureCell(for: image)
	
	//}
	} else {
	print("Could not create image from \(data)")
	}
	}
	
	/* 7. Start the request */
	task.resume()

	*/
	
//	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoImageCell
//		
//		cell.artworkImageView.image = UIImage(named: "film_64")
//		
////		print("MOVIES \(self.movies[indexPath.row])")
//		print("self.MOVIES\(self.movies)")
//		
//		return cell
////		cell.conigureCell(for: "Film Icon")
//	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		print("NumberOFITems \(movies.count) and  \(movies[1])")
		
		return movies.count
	}
}
extension MainViewController: UICollectionViewDelegate{
	
}
/**

extension MainViewController: UITableViewDataSource{


	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let movie = movies[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
		

		return cell
		
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print("Movies Cout \(movies.count)")
		return movies.count
	}
	
	
	
}
extension MainViewController: UITableViewDelegate{
	
	
	
	
	
}
**/

