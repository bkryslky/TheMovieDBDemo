//
//  MovieCollectionViewCell.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 25.04.2021.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    func bind(_ viewModel: MovieCellViewModel) {
        self.imageView.kf.setImage(with: viewModel.imageURL)
        self.imageView.layer.cornerRadius = 15.0
    }
}
