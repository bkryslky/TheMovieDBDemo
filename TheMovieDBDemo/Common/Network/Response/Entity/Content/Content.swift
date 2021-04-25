//
//  Content.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import Foundation

struct Content: Codable {
  
  let id: Int
  let title: String?
  let genreIds: [Int]?
  let overview: String?
  let posterPath: String?
  let backdropPath: String?
  let releaseDate: String?
  let voteAverage: Double?
  let name: String?
  let mediaType: MediaType?
  let knownFor: [Movie]?
  let popularity: Double?
  let profilePath: String?

  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case overview
    case name
    case genreIds = "genre_ids"
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case releaseDate = "release_date"
    case voteAverage = "vote_average"
    case mediaType = "media_type"
    case knownFor = "known_for"
    case popularity
    case profilePath = "profile_path"
  }
  
  func toMovie() -> Movie {
    return Movie(id: id, title: title, genreIds: genreIds, overview: overview, posterPath: posterPath, backdropPath: backdropPath, releaseDate: releaseDate, voteAverage: voteAverage)
  }

  func toPerson() -> Person {
    return Person(id: id, name: name, profilePath: profilePath, popularity: popularity, knownFor: knownFor)
  }
  
}


extension Content {
  var posterImageURL: URL? {
    if let path = posterPath {
      return URL(string: "\(Constants.API.ImageBaseURL)\(path)")
    }
    return nil
  }
  
  var profileImageURL: URL? {
    if let path = profilePath {
      return URL(string: "\(Constants.API.ImageBaseURL)\(path)")
    }
    return nil
  }
}
