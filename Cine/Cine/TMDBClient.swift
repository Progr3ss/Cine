////
////  TMDBClient.swift
////  Cine
////
////  Created by martin chibwe on 10/6/16.
////  Copyright © 2016 Martin Chibwe. All rights reserved.
////
//
//import Foundation
//import Foundation
//
//// MARK: - TMDBClient: NSObject
//
//class TMDBClient : NSObject {
//	
//	// MARK: Properties
//	
//	// shared session
//	var session = URLSession.shared
//	
//	// configuration object
//		var config = TMDBConfig()
//	
//	// authentication state
//	var requestToken: String? = nil
//	var sessionID: String? = nil
//	var userID: Int? = nil
//	
//	// MARK: Initializers
//	override init() {
//		super.init()
//	}
//	
//	// MARK: GET
//	
//	func taskForGETMethod(method: String, parameters: [String:AnyObject], completionHandlerForGET: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
//		
//		/* 1. Set the parameters */
//		var parametersWithApiKey = parameters
//		parametersWithApiKey[ParameterKeys.ApiKey] = Constants.ApiKey as AnyObject?
//		/* 2/3. Build the URL, Configure the request */
//		
//		let request = NSMutableURLRequest(url: tmdbURLFromParameters(parameters: parametersWithApiKey, withPathExtension: method) as URL)
//		
//		/* 4. Make the request */
//		let task = session.dataTask(with: request as URLRequest){(data, response, error) in
//			
//			func sendError(error: String) {
//				print(error)
//				let userInfor = [NSLocalizedDescriptionKey: error]
//				
//				completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code:1, userInfo: userInfor))
//			}
//			
//			/* GUARD: Was there an error? */
//			guard (error == nil) else {
//				sendError(error: "There was an error with your request: \(error)")
//				return
//			}
//			
//			/* GUARD: Did we get a successful 2XX response? */
//			guard let statusCode = (response as? HTTPURLResponse)?.statusCode , statusCode >= 200 && statusCode <= 299 else {
//				sendError(error: "Your request returned a status code other than 2xx!")
//				return
//			}
//			
//			
//			/* GUARD: Was there any data returned? */
//			guard let data = data else {
//				
//				sendError(error: "No data was returned by the request!")
//				return
//			}
//
//		   /* Parse the data and use the data (happens in completion handler) */
//		 self.convertDataWithCompletionHandler(data: data, completionHandlerForConvertData: completionHandlerForGET)
//
//		}
//		task.resume()
//		return task
//		
//	}
//	
//	
//	
//	
//	
//	
//	//	func taskForGETImage(size: String, filePath: String, completionHandlerForImage: (_ imageData: NSData?, _ error: NSError?) -> Void) -> URLSessionTask {
//	//
//	//		/* 1. Set the parameters */
//	//		// There are none...
//	//
//	//		/* 2/3. Build the URL and configure the request */
//	//		let baseURL = NSURL(string: config.baseImageURLString)!
//	//		let url = baseURL.URLByAppendingPathComponent(size)!.URLByAppendingPathComponent(filePath)
//	//		let request = NSURLRequest(URL: url!)
//	//
//	//		/* 4. Make the request */
//	//		let task = session.dataTaskWithRequest(request) { (data, response, error) in
//	//
//	//			func sendError(error: String) {
//	//				print(error)
//	//				let userInfo = [NSLocalizedDescriptionKey : error]
//	//				completionHandlerForImage(imageData: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
//	//			}
//	//
//	//			/* GUARD: Was there an error? */
//	//			guard (error == nil) else {
//	//				sendError("There was an error with your request: \(error)")
//	//				return
//	//			}
//	//
//	//			/* GUARD: Did we get a successful 2XX response? */
//	//			guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode , statusCode >= 200 && statusCode <= 299 else {
//	//				sendError("Your request returned a status code other than 2xx!")
//	//				return
//	//			}
//	//
//	//			/* GUARD: Was there any data returned? */
//	//			guard let data = data else {
//	//				sendError("No data was returned by the request!")
//	//				return
//	//			}
//	//
//	//			/* 5/6. Parse the data and use the data (happens in completion handler) */
//	//			completionHandlerForImage(imageData: data, error: nil)
//	//		}
//	//
//	//		/* 7. Start the request */
//	//		task.resume()
//	//
//	//		return task
//	//	}
//	//
//	// MARK: POST
//	
//	//	func taskForPOSTMethod(method: String, parameters: [String:AnyObject], jsonBody: String, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
//	//
//	//		/* 1. Set the parameters */
//	//		var parametersWithApiKey = parameters
//	//		parametersWithApiKey[ParameterKeys.ApiKey] = Constants.ApiKey as AnyObject?
//	//
//	//		/* 2/3. Build the URL, Configure the request */
//	//		let request = NSMutableURLRequest(url: tmdbURLFromParameters(parameters: parametersWithApiKey, withPathExtension: method) as URL)
//	//		request.httpMethod = "POST"
//	//		request.addValue("application/json", forHTTPHeaderField: "Accept")
//	//		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//	//		request.HTTPBody = jsonBody.data(usingEncoding: NSUTF8StringEncoding)
//	//
//	//		/* 4. Make the request */
//	//		let task = session.dataTaskWithRequest(request as URLRequest) { (data, response, error) in
//	//
//	////			func sendError(error: String) {
//	////				print(error)
//	////				let userInfo = [NSLocalizedDescriptionKey : error]
//	////				completionHandlerForPOST(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
//	////			}
//	//
//	//			/* GUARD: Was there an error? */
//	//			guard (error == nil) else {
//	//				sendError("There was an error with your request: \(error)")
//	//				return
//	//			}
//	//
//	//			/* GUARD: Did we get a successful 2XX response? */
//	//			guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode , statusCode >= 200 && statusCode <= 299 else {
//	//				sendError("Your request returned a status code other than 2xx!")
//	//				return
//	//			}
//	//
//	//			/* GUARD: Was there any data returned? */
//	//			guard let data = data else {
//	//				sendError("No data was returned by the request!")
//	//				return
//	//			}
//	//
//	//			/* 5/6. Parse the data and use the data (happens in completion handler) */
//	//			self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForPOST)
//	//		}
//	//
//	//		/* 7. Start the request */
//	//		task.resume()
//	//
//	//		return task
//	//	}
//	
//	
//	
//	
//	// MARK: Helpers
//	
//	// substitute the key for the value that is contained within the method name
//	func substituteKeyInMethod(method: String, key: String, value: String) -> String? {
//		if method.range(of: "{\(key)}") != nil {
//			return method.replacingOccurrences(of: "{\(key)}", with: value)
//		} else {
//			return nil
//		}
//	}
//	
//	// given raw JSON, return a usable Foundation object
//	
//	
//	private func convertDataWithCompletionHandler(data: Data , completionHandlerForConvertData: (_ result: AnyObject?,_ error: NSError?) -> Void) {
//		
//		var parsedResult: AnyObject!
//		
//		do {
//			
//			parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
//			
//			
//		}catch{
//			let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
//			completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
//			
//		}
//		
//		completionHandlerForConvertData(parsedResult, nil)
//	}
//	
//	
//	// create a URL from parameters
//	private func tmdbURLFromParameters(parameters: [String:AnyObject], withPathExtension: String? = nil) -> NSURL {
//		
//		let components = NSURLComponents()
//		components.scheme = TMDBClient.Constants.ApiScheme
//		components.host = TMDBClient.Constants.ApiHost
//		components.path = TMDBClient.Constants.ApiPath + (withPathExtension ?? "")
//		components.queryItems = [NSURLQueryItem]() as [URLQueryItem]?
//		
//		for (key, value) in parameters {
//			let queryItem = NSURLQueryItem(name: key, value: "\(value)")
//			components.queryItems!.append(queryItem as URLQueryItem)
//		}
//		
//		print("components.url \(components.url!)")
//		return components.url! as NSURL
//	}
//	
//	// MARK: Shared Instance
//	
//	class func sharedInstance() -> TMDBClient {
//		struct Singleton {
//			static var sharedInstance = TMDBClient()
//		}
//		return Singleton.sharedInstance
//	}
//}
