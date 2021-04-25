//
//  Person.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import Foundation

struct Person: Codable {
  
  let id: Int
  let name: String?
  let profilePath: String?
  let popularity: Double?
  let knownFor: [Movie]?

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case profilePath = "profile_path"
    case popularity
    case knownFor = "known_for"
  }
}
