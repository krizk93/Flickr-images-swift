//
//  ResultsViewController.swift
//  flickr-images
//
//  Created by Karim Rizk on 05.06.21.
//  Copyright © 2021 Karim Rizk. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
	
	// MARK: outlets
	
	@IBOutlet private weak var photosCollectionView: UICollectionView!
	@IBOutlet private weak var errorLabel: UILabel!
	
	
	// MARK: static properties
	
	static let identifier = "ResultsViewController"
	
	// MARK: private properties
	
	private var queryItem: String?
	private let networkManager = NetworkManager()
	private var data = [Photo]()
	
	
	// MARK: init
	
	class func instancewith(queryItem:String) -> ResultsViewController {
		
		
		let viewController = UIStoryboard(name: Constants.Storyboard.main, bundle: nil).instantiateViewController(identifier: ResultsViewController.identifier) as ResultsViewController
		viewController.queryItem = queryItem
		
		return viewController
	}
	
	
	// MARK: lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let queryItem = queryItem else { return }
		self.title = queryItem
		
		self.errorLabel.isHidden = true
		
		self.photosCollectionView.register(PhotoCollectionViewCell.nib(), forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
		self.photosCollectionView.dataSource = self
		
		self.searchPhotos(with: queryItem)
		
	}
	
	// MARK: private functions
	
	private func searchPhotos(with query: String) {
		
		networkManager.getSearchResults(query: query) { result in
			
			switch result {
				
			case .success(let response):
				if let photos = response.photos, let photo = photos.photo {
					
					self.data = photo
					self.photosCollectionView.reloadData()
				}
				
				if self.data.isEmpty {
					
					self.displayErrorMessage(errorMessage: Constants.ErrorMessage.noResults)
					
				}
				
			case .failure(let error):
				print("Error fetching data: \(error.localizedDescription)")
				self.displayErrorMessage(errorMessage: Constants.ErrorMessage.customError + error.localizedDescription)
			}
			
		}
		
	}
	
	
	private func displayErrorMessage(errorMessage: String) {
		
		self.errorLabel.isHidden = false
		self.errorLabel.text = errorMessage
	}
	
}

// MARK: - UICollectionViewDataSource

extension ResultsViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.data.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = self.photosCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
		cell.configure(with: self.data[indexPath.item])
		
		return cell
	}
	
	
}
