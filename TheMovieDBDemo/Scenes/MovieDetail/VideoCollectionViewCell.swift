//
//  VideoCollectionViewCell.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 24.04.2021.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func bind(_ viewModel: VideoCellViewModel) {
        self.titleLabel.text = viewModel.name
        self.imageView.layer.cornerRadius = 15.0
    }
}
