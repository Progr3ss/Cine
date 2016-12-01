//
//  TMDBGetMethods.swift
//  Cine
//
//  Created by martin chibwe on 11/22/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import Foundation


extension TMDBClient {
	
	
//	var appDelegate: AppDelegate!
	
	
	func getNowPlayingMovies(page:Int, _ completionHandlerForNowPlaying: @escaping (_ result: [TMDBMovie]?, _ error: NSError?) -> Void)
	{
		/* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
		let parameters = [TMDBClient.ParameterKeys.ApiKey: TMDBClient.Constants.ApiKey,
		                  TMDBClient.JSONResponseKeys.Moviepage: page] as [String : Any]
		
		var mutableMethod: String = Methods.MoviesPlayingNow
		//		mutableMethod = substituteKeyInMethod(mutableMethod, key: TMDBClient.URLKeys.UserID, value: String(TMDBClient.sharedInstance().userID!))!
		
		let _ = taskForGETMethod(mutableMethod, parameters: parameters as [String : AnyObject], completionHandlerForGET: {(results, error ) in
			
			print("Results \(results)")
			if let error = error {
				completionHandlerForNowPlaying(nil, error)
				
				
				
			}else {
				
				if let results = results?[TMDBClient.JSONResponseKeys.MovieResults] as? [[String: AnyObject]]{
					let movies = TMDBMovie.moviesFromResults(results)
					completionHandlerForNowPlaying(movies, nil)
					
				}else{
					
					completionHandlerForNowPlaying(nil, NSError(domain: "getNowPlayingMovies", code: 0, userInfo:
						[NSLocalizedDescriptionKey:"Could not parse getNowPlayingMovies"]))
				}
			}
			
		})
		
	}
	
	func getMovieVideos(movieId: Int, _ completionHandlerForNowPlaying: @escaping (_ result: [TMDBTrailers]?, _ error: NSError?) -> Void)
	{
		/* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
		let parameters = [TMDBClient.ParameterKeys.ApiKey: TMDBClient.Constants.ApiKey,
		                  TMDBClient.JSONResponseKeys.MovieVideoID: movieId] as [String : Any]
		
		var mutableMethod: String = Methods.MovieVideos
		
			mutableMethod = substituteKeyInMethod(mutableMethod, key:"movie_id", value:String(movieId))!
		
		let _ = taskForGETMethod(mutableMethod, parameters: parameters as [String : AnyObject], completionHandlerForGET: {(results, error ) in
			
			print("getMovieVideos \(results)")
			if let error = error {
				completionHandlerForNowPlaying(nil, error)
				
				
				
			}else {
				
				if let results = results?[TMDBClient.JSONResponseKeys.MovieResults] as? [[String: AnyObject]]{
					let movies = TMDBTrailers.moviesFromResults(results)
					completionHandlerForNowPlaying(movies, nil)
					
				}else{
					
					completionHandlerForNowPlaying(nil, NSError(domain: "getMovieVideos", code: 0, userInfo:
						[NSLocalizedDescriptionKey:"Could not parse getMovieVideosr"]))
				}
			}
			
		})
		
	}
	
	
	
}


