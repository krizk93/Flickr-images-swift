//
//  Constants.swift
//  flickr-images
//
//  Created by Karim Rizk on 05.06.21.
//  Copyright © 2021 Karim Rizk. All rights reserved.
//

import Foundation

enum Constants {
	
	enum API {
		
		static let photoSearchMethod = "flickr.photos.search"
		static let apiKey = "e6789f992c39dd8b5509c81e429cbd05"
		
	}
	
	enum ErrorMessage {
		
		static let noResults = "No results found"
		static let customError = "Error fetching data: "
	}
	
	enum Storyboard {
		
		static let main = "Main"
	}
}
