//: Playground - noun: a place where people can play

import UIKit







import Foundation





var array = [String: AnyObject]()


array.updateValue(3 as AnyObject, forKey: "martin")

var ad = {[String: AnyObject]()}
array
ad
var b = {}
b
//
//let headers = ["content-type": "application/json"]
//let parameters = []
//
////let postData = JSONSerialization.dataWithJSONObject(parameters, options: nil, error: nil)
//do {
//	let postData = JSONSerialization.jsonObject(with: parameters, options: .allowFragments) as AnyObject
//}
////let postData = JSONSerialization.jsonObject(with: parameters, options: .allowFragments) as AnyObject
//
//var request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/latest?language=en-US&api_key=2007a6ba55005dd305c31f4d13354605")! as URL,
//                                  cachePolicy: .useProtocolCachePolicy,
//                                  timeoutInterval: 10.0)
//request.httpMethod = "GET"
//request.allHTTPHeaderFields = headers
//request.HTTPBody = postData
//
//let session = URLSession.shared
//let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//	if (error != nil) {
//		print(error)
//	} else {
//		let httpResponse = response as? HTTPURLResponse
//		print(httpResponse)
//	}
//})
//
//dataTask.resume()


//var str = "Hello, playground"
//
//let a  = 3
//
//let b = 4
//var c = a ?? b
//print(c)
//
//let components = NSURLComponents()
//
//components.scheme = "https"
//components.host = "api.themoviedb.org"
//print(components.scheme!)
//
//func tmdbURLFromParameters2(parameters: [String: AnyObject], withPathExtension: String? = nil) -> NSURL {
//	
//	let components = NSURLComponents()
//	
//	components.scheme = "https"
//	components.host = "api.themoviedb.org"
//	components.path = "/3" + (withPathExtension ?? "")
//	components.queryItems = [NSURLQueryItem]() as [URLQueryItem]?
//	
//	for (key, value) in parameters {
//		let queryItem = NSURLQueryItem(name: key, value: "\(value)")
//		components.queryItems!.append(queryItem as URLQueryItem)
//	}
//	
//	
//	return components.url! as NSURL
//	
//}
//
//
//func tmdbURLFromParameters(parameters: [String:AnyObject], withPathExtension: String? = nil) -> NSURL {
//	
//	let components = NSURLComponents()
//	components.scheme = "https"
//	components.host = "api.themoviedb.org"
//	components.path = "/3" + (withPathExtension ?? "")
//	components.queryItems = [NSURLQueryItem]() as [URLQueryItem]?
//	
//	for (key, value) in parameters {
//		let queryItem = NSURLQueryItem(name: key, value: "\(value)")
//		components.queryItems!.append(queryItem as URLQueryItem)
//	}
//	print("components.url \(components.url!)")
//	return components.url! as NSURL
//}
//
//let methodParameters = [
//	"api_key" :  "2007a6ba55005dd305c31f4d13354605" as AnyObject
//	
//]
//let reqeust = tmdbURLFromParameters2(parameters: methodParameters, withPathExtension: "/authentication/token/new")
//
//print(reqeust)
//
////print("http://api.themoviedb.org/3/genre/878/movies?api_key=2007a6ba55005dd305c31f4d13354605")
