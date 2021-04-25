//
//  TVsCellViewModel.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 25.04.2021.
//

import Foundation
class TVsCellViewModel{
    
    let name: String
    let imageURL: URL?
    let movie: Movie
    
    //MARK: TODO
    //This is dummy model for TVs Cell.
    init(with movie: Movie) {
        self.movie = movie
        self.name = movie.title ?? ""
        self.imageURL = movie.profileImageURL
    }
    
}
