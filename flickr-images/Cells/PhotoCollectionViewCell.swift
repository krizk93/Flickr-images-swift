//
//  PhotoCollectionViewCell.swift
//  flickr-images
//
//  Created by Karim Rizk on 05.06.21.
//  Copyright © 2021 Karim Rizk. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoCollectionViewCell: UICollectionViewCell {
	
	// MARK: outlets
	@IBOutlet weak var photoImageView: UIImageView!
	
	
	// MARK: static properties
	
	static let identifier = "PhotoCollectionViewCell"
	
	static func nib() -> UINib {
		
		return UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
	}
	
	// MARK: private properties
	
	private var photo: Photo?
	
	
	
	// MARK: init
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
	func configure(with photo: Photo) {
		
		self.photo = photo
		self.loadImage(photo: photo)
	}
	
	// MARK: private functions
	
	private func loadImage(photo: Photo) {
		
		guard let farm = photo.farm,
			let server = photo.server,
			let id = photo.id,
			let secret = photo.secret,
			let url = URL(string: "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg")
			
			else { return }
		
		self.photoImageView.af.setImage(withURL: url)
		
		
	}
	
}
