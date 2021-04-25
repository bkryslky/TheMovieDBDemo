//
//  ContentCollectionViewCell.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 20.04.2021.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

}
