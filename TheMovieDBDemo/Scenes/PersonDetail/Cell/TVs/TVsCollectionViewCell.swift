//
//  TVsCollectionViewCell.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 25.04.2021.
//

import UIKit

class TVsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bind(_ viewModel: TVsCellViewModel) {
      self.titleLabel.text = viewModel.name
      self.imageView.kf.setImage(with: viewModel.imageURL)
        self.imageView.layer.cornerRadius = 15.0
    }
}
