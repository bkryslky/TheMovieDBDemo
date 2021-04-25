//
//  PersonDetail.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import Foundation

enum Gender: Int, Codable {
  case none
  case male
  case female
}

struct PersonDetail: Codable {
  
  let id: Int
  let name: String?
  let profilePath: String?
  let popularity: Double?
  let knownFor: [Movie]?
  let birthday: String?
  let deathday: String?
  let knownForDepartment: String?
  let gender: Gender?
  let alsoKnownAs: [String]?
  let biography: String?
  let birthPlace: String?
  let credits: Credit?

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case profilePath = "profile_path"
    case popularity
    case knownFor = "known_for"
    case birthday
    case deathday
    case knownForDepartment = "known_for_department"
    case gender
    case biography
    case alsoKnownAs = "also_known_as"
    case birthPlace = "place_of_birth"
    case credits
  }
}

extension PersonDetail {
  var profileImageURL: URL? {
    if let path = profilePath {
      return URL(string: "\(Constants.API.ImageBaseURL)\(path)")
    }
    return nil
  }
}
