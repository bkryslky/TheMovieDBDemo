//
//  Credit.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import Foundation

struct Credit: Codable {
  let cast: [Cast]?
  let crew: [Crew]?
}
