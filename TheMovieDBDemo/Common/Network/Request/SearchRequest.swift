//
//  SearchMultiRequestEntity.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import Foundation

struct SearchRequest: Codable {
  let query: String
  let page: Int
}
