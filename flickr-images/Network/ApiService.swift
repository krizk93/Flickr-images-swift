//
//  ApiService.swift
//  flickr-images
//
//  Created by Karim Rizk on 05.06.21.
//  Copyright © 2021 Karim Rizk. All rights reserved.
//

import Foundation
import Moya

enum APIService {
	
	case search(query: String)
}

extension APIService: TargetType {
	
	
	var baseURL: URL {
		guard let url = URL(string: "https://api.flickr.com/services/rest") else { fatalError() }
		return url
	}
	
	var path: String {
		switch self {
			
		case .search:
			return "/"
			
		}
	}
	
	var method: Moya.Method {
		switch self {
			
		case .search:
			return .get
		}
		
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		switch self {
			
		case .search(let query):
			return .requestParameters(
				parameters:
				["method": Constants.API.photoSearchMethod,
				 "api_key": Constants.API.apiKey,
				 "format": "json",
				 "nojsoncallback": "1",
				 "safe_search": "1",
				 "text": query],
				encoding: URLEncoding.queryString)
		}
	}
	
	var headers: [String : String]? {
		return nil
	}
	
	
	
}
