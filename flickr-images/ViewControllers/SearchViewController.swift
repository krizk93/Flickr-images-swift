//
//  SearchViewController.swift
//  flickr-images
//
//  Created by Karim Rizk on 05.06.21.
//  Copyright © 2021 Karim Rizk. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
	
	// MARK: IBOutlets
	
	
	// MARK: Private properties
	
	private let searchController = UISearchController()
	
	
	// MARK: Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "Search"
		self.navigationItem.searchController = searchController
		searchController.searchResultsUpdater = self
		searchController.searchBar.delegate = self
		
	}
	
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
	
	
	func updateSearchResults(for searchController: UISearchController) {
	}
	
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		
		if let query = searchBar.text {

			let resultViewController = ResultsViewController.instancewith(queryItem: query)
			self.navigationController?.pushViewController(resultViewController, animated: true)
		}
		
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
	}
}

