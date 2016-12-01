//
//  TMDBTrailers.swift
//  Cine
//
//  Created by martin chibwe on 11/30/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import Foundation
import Foundation

struct TMDBTrailers {
	
	// MARK: Properties
	
	let name: String
	let key: String
//	let id: Int
//	let posterPath: String?
//	let releaseYear: String?
	
	// MARK: Initializers
	
	// construct a TMDBMovie from a dictionary
	init(dictionary: [String:AnyObject]) {
		name = dictionary[TMDBClient.JSONResponseKeys.TrailerName] as! String
		key = dictionary[TMDBClient.JSONResponseKeys.TrailerKey] as! String
//		id = dictionary[TMDBClient.JSONResponseKeys.MovieID] as! Int

	}
	
	static func moviesFromResults(_ results: [[String:AnyObject]]) -> [TMDBTrailers] {
		
		var movies = [TMDBTrailers]()
		
		// iterate through array of dictionaries, each Movie is a dictionary
		for result in results {
			movies.append(TMDBTrailers(dictionary: result))
		}
		
		return movies
	}
}

// MARK: - TMDBMovie: Equatable

//extension TMDBTrailers: Equatable {}
//
//func ==(lhs: TMDBTrailers, rhs: TMDBTrailers) -> Bool {
//	return lhs.id == rhs.id
//}
