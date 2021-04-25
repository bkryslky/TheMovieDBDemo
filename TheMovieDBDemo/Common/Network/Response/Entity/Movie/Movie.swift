//
//  Movie.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import Foundation

struct Movie: Codable {
  
  let id: Int
  let title: String?
  let genreIds: [Int]?
  let overview: String?
  let posterPath: String?
  let backdropPath: String?
  let releaseDate: String?
  let voteAverage: Double?
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case overview
    case genreIds = "genre_ids"
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case releaseDate = "release_date"
    case voteAverage = "vote_average"
  }
}
extension Movie {
  var profileImageURL: URL? {
    if let path = posterPath {
      return URL(string: "\(Constants.API.ImageBaseURL)\(path)")
    }
    return nil
  }
}

