//
//  TMDBMovie.swift
//  Cine
//
//  Created by martin chibwe on 10/11/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import Foundation

//MARK: - TMDBMovie

struct TMDBMovie {
	
	// MARK: Properties
	
	let title : String
	let id: Int
//	let popularity: Int
//	var releaseDate: String?
//	let overview: String?
	let posterPath: String?
//	let releaseYear: String?
//	let genreId: Int
//	let page : Int
	
	
	//MARK: Initializers
	
	init(dictionary: [String: AnyObject]) {
		title = dictionary[Constants.TMDBResponseKeys.Title] as! String
		id = dictionary[Constants.TMDBResponseKeys.ID] as! Int
//		overview = dictionary[Constants.TMDBResponseKeys.Overview] as? String
		posterPath = dictionary[Constants.TMDBResponseKeys.PosterPath] as? String
//		releaseYear = dictionary[Constants.TMDBResponseKeys.ReleaseDate] as? String
//		genreId = (dictionary[Constants.TMDBResponseKeys.Genre_ids] as? Int)!
//		popularity = (dictionary[Constants.TMDBResponseKeys.Popularity] as? Int)!
//		page = (dictionary[Constants.TMDBResponseKeys.Page] as? Int)!
	}
	

		static func movieFromResults(results: [[String: AnyObject]]) -> [TMDBMovie] {
			var movies = [TMDBMovie]()
		
			for result in results {
				
				movies.append(TMDBMovie(dictionary: result))
			}
			
			
		
			return movies
		}
		
	}
	// MARK: - TMDBMovie: Equatable
	
	
	


// MARK: - TMDBMovie: Equatable

extension TMDBMovie: Equatable {}

func ==(lhs: TMDBMovie, rhs: TMDBMovie) -> Bool {
	return lhs.id == rhs.id
}

