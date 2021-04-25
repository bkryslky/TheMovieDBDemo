//
//  MovieCellViewModel.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 25.04.2021.
//

import Foundation
class MovieCellViewModel{
    
    let imageURL:URL?
    let movie:Movie
    init(with movie:Movie) {
        self.movie = movie
        self.imageURL = movie.profileImageURL
    }
}
