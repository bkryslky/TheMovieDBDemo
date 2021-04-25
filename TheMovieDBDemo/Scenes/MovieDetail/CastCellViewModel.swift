//
//  CastCellViewModel.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 24.04.2021.
//

import Foundation
class CastCellViewModel{
  
  let name: String
  let imageURL: URL?
  let character: String
  
  let cast: Cast
  
  init(with cast: Cast) {
    self.cast = cast
    self.name = cast.name ?? ""
    self.character = cast.character ?? ""
    
    self.imageURL = cast.profileImageURL
  }
}
