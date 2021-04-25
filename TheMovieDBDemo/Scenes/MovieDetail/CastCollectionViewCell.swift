//
//  CastCollectionViewCell.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 24.04.2021.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func bind(_ viewModel: CastCellViewModel) {
      self.titleLabel.text = viewModel.name
      self.imageView.kf.setImage(with: viewModel.imageURL)
        self.imageView.layer.cornerRadius = 15.0
    }
}
