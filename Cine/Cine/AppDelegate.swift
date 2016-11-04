//
//  AppDelegate.swift
//  Cine
//
//  Created by martin chibwe on 10/1/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit

// MARK: - AppDelegate: UIResponder, UIApplicationDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	// MARK: Properties
	
	var window: UIWindow?
	
	var sharedSession = URLSession.shared
	var requestToken: String? = nil
	var sessionID: String? = nil
	var guestSessionID : String?  = nil
	var userID: Int? = nil
	
	// configuration for TheMovieDB, we'll take care of this for you =)...
	var config = Config()
	
	// MARK: UIApplicationDelegate
	
	private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		
		// if necessary, update the configuration...
		config.updateIfDaysSinceUpdateExceeds(days: 7)
		
		return true
	}
}

// MARK: Create URL from Parameters

extension AppDelegate {
	
	
	func tmdbURLFromParameters(parameters: [String: AnyObject], withPathExtension: String? = nil) -> NSURL {
		
		let components = NSURLComponents()
		
		components.scheme = "https"
		components.host = "api.themoviedb.org"
		components.path = "/3" + (withPathExtension ?? "")
		components.queryItems = [NSURLQueryItem]() as [URLQueryItem]?
		
		for (key, value) in parameters {
			let queryItem = NSURLQueryItem(name: key, value: "\(value)")
			components.queryItems!.append(queryItem as URLQueryItem)
		}
		
		print("Components.url \(components.url)")
		return components.url! as NSURL
		
	}
	

}

