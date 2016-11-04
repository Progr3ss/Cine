////
////  TMDBConvenience.swift
////  Cine
////
////  Created by martin chibwe on 10/7/16.
////  Copyright © 2016 Martin Chibwe. All rights reserved.
////
//
//import UIKit
//import Foundation
//
//
// //MARK: - TMDBClient (Convenient Resource Methods)
//
//extension TMDBClient {
//	
//	
//	
////	print(Methods.AuthenticationTokenNew)
//	// MARK: Authentication (GET) Methods
//	/*
//	Steps for Authentication...
//	https://www.themoviedb.org/documentation/api/sessions
//	
//	Step 1: Create a new request token
//	Step 2a: Ask the user for permission via the website
//	Step 3: Create a session ID
//	Bonus Step: Go ahead and get the user id 😄!
//	*/
////	func authenticateWithViewController(hostViewController: UIViewController, completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
////	
////		// chain completion handlers for each request so that they run one after the other
////		
////		
////		
////		getRequestToken() { (success, requestToken, errorString) in
//////
////			if success {
//////
//////				// success! we have the requestToken!
////				self.requestToken = requestToken
////				
////				self.loginWithToken(requestToken: requestToken, hostViewController: hostViewController) { (success, errorString) in
////					
////					if success {
////						self.getSessionID(requestToken) { (success, sessionID, errorString) in
////							
////							if success {
////								
////								// success! we have the sessionID!
////								self.sessionID = sessionID
////								
////								self.getUserID() { (success, userID, errorString) in
////									
////									if success {
////										
////										if let userID = userID {
////											
////											// and the userID 😄!
////											self.userID = userID
////										}
////									}
////									
////									completionHandlerForAuth(success: success, errorString: errorString)
////								}
////							} else {
////								completionHandlerForAuth(success: success, errorString: errorString)
////							}
////						}
////					} else {
////						completionHandlerForAuth(success, errorString)
////					}
////				}
////			} else {
////				completionHandlerForAuth(success, errorString)
////			}
////		}
////	}
////	
//
//	private func getRequestToken(completionHandlerForToken: @escaping (_ success: Bool, _ requestToken: String?, _ errorString: String?) -> Void) {
//		
//		/* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
//		let parameters = [String:AnyObject]()
//		
//		
//		/* 2. Make the request */
//
//		
//		taskForGETMethod(method: Methods.AuthenticationTokenNew, parameters: parameters) { (results, error) in
//			
//			/* 3. Send the desired value(s) to completion handler */
//			if let error = error {
//				print(error)
//				completionHandlerForToken(false, nil, "Login Failed (Request Token).")
//				
//			} else {
//				if let requestToken = results?[TMDBClient.JSONResponseKeys.RequestToken] as? String {
//					completionHandlerForToken(true, requestToken, nil)
//					
//				} else {
//					print("Could not find \(TMDBClient.JSONResponseKeys.RequestToken) in \(results)")
//					completionHandlerForToken(false, nil, "Login Failed (Request Token).")
//				}
//			}
//		}
//	}
////
////	/* This function opens a TMDBAuthViewController to handle Step 2a of the auth flow */
////	private func loginWithToken(requestToken: String?, hostViewController: UIViewController, completionHandlerForLogin: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
////		
////		let authorizationURL = NSURL(string: "\(TMDBClient.Constants.AuthorizationURL)\(requestToken!)")
////		let request = NSURLRequest(url: authorizationURL! as URL)
////		let webAuthViewController = hostViewController.storyboard!.instantiateViewControllerWithIdentifier("TMDBAuthViewController") as! TMDBAuthViewController
////		webAuthViewController.urlRequest = request
////		webAuthViewController.requestToken = requestToken
////		webAuthViewController.completionHandlerForView = completionHandlerForLogin
////		
////		let webAuthNavigationController = UINavigationController()
////		webAuthNavigationController.pushViewController(webAuthViewController, animated: false)
////		
////		performUIUpdatesOnMain {
////			hostViewController.present(webAuthNavigationController, animated: true, completion: nil)
////		}
////	}
////
////	private func getSessionID(requestToken: String?, completionHandlerForSession: (success: Bool, sessionID: String?, errorString: String?) -> Void) {
////		
////		/* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
////		let parameters = [TMDBClient.ParameterKeys.RequestToken: requestToken!]
////		
////		/* 2. Make the request */
////		taskForGETMethod(Methods.AuthenticationSessionNew, parameters: parameters) { (results, error) in
////			
////			/* 3. Send the desired value(s) to completion handler */
////			if let error = error {
////				print(error)
////				completionHandlerForSession(success: false, sessionID: nil, errorString: "Login Failed (Session ID).")
////			} else {
////				if let sessionID = results[TMDBClient.JSONResponseKeys.SessionID] as? String {
////					completionHandlerForSession(success: true, sessionID: sessionID, errorString: nil)
////				} else {
////					print("Could not find \(TMDBClient.JSONResponseKeys.SessionID) in \(results)")
////					completionHandlerForSession(success: false, sessionID: nil, errorString: "Login Failed (Session ID).")
////				}
////			}
////		}
////	}
////	
////	private func getUserID(completionHandlerForUserID: (success: Bool, userID: Int?, errorString: String?) -> Void) {
////		
////		/* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
////		let parameters = [TMDBClient.ParameterKeys.SessionID: TMDBClient.sharedInstance().sessionID!]
////		
////		/* 2. Make the request */
////		taskForGETMethod(Methods.Account, parameters: parameters) { (results, error) in
////			
////			/* 3. Send the desired value(s) to completion handler */
////			if let error = error {
////				print(error)
////				completionHandlerForUserID(success: false, userID: nil, errorString: "Login Failed (User ID).")
////			} else {
////				if let userID = results[TMDBClient.JSONResponseKeys.UserID] as? Int {
////					completionHandlerForUserID(success: true, userID: userID, errorString: nil)
////				} else {
////					print("Could not find \(TMDBClient.JSONResponseKeys.UserID) in \(results)")
////					completionHandlerForUserID(success: false, userID: nil, errorString: "Login Failed (User ID).")
////				}
////			}
////		}
////	}
////	
////	// MARK: GET Convenience Methods
////	
////	func getFavoriteMovies(completionHandlerForFavMovies: (result: [TMDBMovie]?, error: NSError?) -> Void) {
////		
////		/* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
////		let parameters = [TMDBClient.ParameterKeys.SessionID: TMDBClient.sharedInstance().sessionID!]
////		var mutableMethod: String = Methods.AccountIDFavoriteMovies
////		mutableMethod = substituteKeyInMethod(mutableMethod, key: TMDBClient.URLKeys.UserID, value: String(TMDBClient.sharedInstance().userID!))!
////		
////		/* 2. Make the request */
////		taskForGETMethod(mutableMethod, parameters: parameters) { (results, error) in
////			
////			/* 3. Send the desired value(s) to completion handler */
////			if let error = error {
////				completionHandlerForFavMovies(result: nil, error: error)
////			} else {
////				
////				if let results = results[TMDBClient.JSONResponseKeys.MovieResults] as? [[String:AnyObject]] {
////					
////					let movies = TMDBMovie.moviesFromResults(results)
////					completionHandlerForFavMovies(result: movies, error: nil)
////				} else {
////					completionHandlerForFavMovies(result: nil, error: NSError(domain: "getFavoriteMovies parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getFavoriteMovies"]))
////				}
////			}
////		}
////	}
////	
////	func getWatchlistMovies(completionHandlerForWatchlist: (result: [TMDBMovie]?, error: NSError?) -> Void) {
////		
////		/* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
////		let parameters = [TMDBClient.ParameterKeys.SessionID: TMDBClient.sharedInstance().sessionID!]
////		var mutableMethod: String = Methods.AccountIDWatchlistMovies
////		mutableMethod = substituteKeyInMethod(mutableMethod, key: TMDBClient.URLKeys.UserID, value: String(TMDBClient.sharedInstance().userID!))!
////		
////		/* 2. Make the request */
////		taskForGETMethod(mutableMethod, parameters: parameters) { (results, error) in
////			
////			/* 3. Send the desired value(s) to completion handler */
////			if let error = error {
////				completionHandlerForWatchlist(result: nil, error: error)
////			} else {
////				
////				if let results = results[TMDBClient.JSONResponseKeys.MovieResults] as? [[String:AnyObject]] {
////					
////					let movies = TMDBMovie.moviesFromResults(results)
////					completionHandlerForWatchlist(result: movies, error: nil)
////				} else {
////					completionHandlerForWatchlist(result: nil, error: NSError(domain: "getWatchlistMovies parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getWatchlistMovies"]))
////				}
////			}
////		}
////	}
////	
////	func getMoviesForSearchString(searchString: String, completionHandlerForMovies: (result: [TMDBMovie]?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
////		
////		/* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
////		let parameters = [TMDBClient.ParameterKeys.Query: searchString]
////		
////		/* 2. Make the request */
////		let task = taskForGETMethod(Methods.SearchMovie, parameters: parameters) { (results, error) in
////			
////			/* 3. Send the desired value(s) to completion handler */
////			if let error = error {
////				completionHandlerForMovies(result: nil, error: error)
////			} else {
////				
////				if let results = results[TMDBClient.JSONResponseKeys.MovieResults] as? [[String:AnyObject]] {
////					
////					let movies = TMDBMovie.moviesFromResults(results)
////					completionHandlerForMovies(result: movies, error: nil)
////				} else {
////					completionHandlerForMovies(result: nil, error: NSError(domain: "getMoviesForSearchString parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getMoviesForSearchString"]))
////				}
////			}
////		}
////		
////		return task
////	}
////	
////	func getConfig(completionHandlerForConfig: (didSucceed: Bool, error: NSError?) -> Void) {
////		
////		/* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
////		let parameters = [String:AnyObject]()
////		
////		/* 2. Make the request */
////		taskForGETMethod(Methods.Config, parameters: parameters) { (results, error) in
////			
////			/* 3. Send the desired value(s) to completion handler */
////			if let error = error {
////				completionHandlerForConfig(didSucceed: false, error: error)
////			} else if let newConfig = TMDBConfig(dictionary: results as! [String:AnyObject]) {
////				self.config = newConfig
////				completionHandlerForConfig(didSucceed: true, error: nil)
////			} else {
////				completionHandlerForConfig(didSucceed: false, error: NSError(domain: "getConfig parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getConfig"]))
////			}
////		}
////	}
////	
////	// MARK: POST Convenience Methods
////	
////	func postToFavorites(movie: TMDBMovie, favorite: Bool, completionHandlerForFavorite: (result: Int?, error: NSError?) -> Void)  {
////		
////		/* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
////		let parameters = [TMDBClient.ParameterKeys.SessionID : TMDBClient.sharedInstance().sessionID!]
////		var mutableMethod: String = Methods.AccountIDFavorite
////		mutableMethod = substituteKeyInMethod(mutableMethod, key: TMDBClient.URLKeys.UserID, value: String(TMDBClient.sharedInstance().userID!))!
////		let jsonBody = "{\"\(TMDBClient.JSONBodyKeys.MediaType)\": \"movie\",\"\(TMDBClient.JSONBodyKeys.MediaID)\": \"\(movie.id)\",\"\(TMDBClient.JSONBodyKeys.Favorite)\": \(favorite)}"
////		
////		/* 2. Make the request */
////		taskForPOSTMethod(mutableMethod, parameters: parameters, jsonBody: jsonBody) { (results, error) in
////			
////			/* 3. Send the desired value(s) to completion handler */
////			if let error = error {
////				completionHandlerForFavorite(result: nil, error: error)
////			} else {
////				if let results = results[TMDBClient.JSONResponseKeys.StatusCode] as? Int {
////					completionHandlerForFavorite(result: results, error: nil)
////				} else {
////					completionHandlerForFavorite(result: nil, error: NSError(domain: "postToFavoritesList parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postToFavoritesList"]))
////				}
////			}
////		}
////	}
////	
////	func postToWatchlist(movie: TMDBMovie, watchlist: Bool, completionHandlerForWatchlist: (result: Int?, error: NSError?) -> Void) {
////		
////		/* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
////		let parameters = [TMDBClient.ParameterKeys.SessionID : TMDBClient.sharedInstance().sessionID!]
////		var mutableMethod: String = Methods.AccountIDWatchlist
////		mutableMethod = substituteKeyInMethod(mutableMethod, key: TMDBClient.URLKeys.UserID, value: String(TMDBClient.sharedInstance().userID!))!
////		let jsonBody = "{\"\(TMDBClient.JSONBodyKeys.MediaType)\": \"movie\",\"\(TMDBClient.JSONBodyKeys.MediaID)\": \"\(movie.id)\",\"\(TMDBClient.JSONBodyKeys.Watchlist)\": \(watchlist)}"
////		
////		/* 2. Make the request */
////		taskForPOSTMethod(mutableMethod, parameters: parameters, jsonBody: jsonBody) { (results, error) in
////			
////			/* 3. Send the desired value(s) to completion handler */
////			if let error = error {
////				completionHandlerForWatchlist(result: nil, error: error)
////			} else {
////				if let results = results[TMDBClient.JSONResponseKeys.StatusCode] as? Int {
////					completionHandlerForWatchlist(result: results, error: nil)
////				} else {
////					completionHandlerForWatchlist(result: nil, error: NSError(domain: "postToWatchlist parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postToWatchlist"]))
////				}
////			}
////		}
////	}
//}
