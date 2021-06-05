//
//  NetworkManager.swift
//  flickr-images
//
//  Created by Karim Rizk on 05.06.21.
//  Copyright © 2021 Karim Rizk. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
	
	var provider: MoyaProvider<APIService> { get }
	
	func getSearchResults(query: String, completion: @escaping (Result<PhotosResponse, Error>) -> ())
}

class NetworkManager: Networkable {
	
	var provider = MoyaProvider<APIService>()
	
	func getSearchResults(query: String, completion: @escaping (Result<PhotosResponse, Error>) -> ()) {
		
		request(target: .search(query: query), completion: completion)
	}
}

private extension NetworkManager {
	
	private func request<T: Decodable>(target: APIService, completion: @escaping (Result<T, Error>) -> ()) {
		
		provider.request(target) { result in
			
			switch result {
				
			case let .success(response):
				do {
					let results = try JSONDecoder().decode(T.self, from: response.data)
					completion(.success(results))
					
				} catch let error {
					completion(.failure(error))
				}
				
			case let .failure(error):
				completion(.failure(error))
			}
		}
	}
}


