//
//  Identifiable.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import Foundation
import UIKit

protocol Identifiable {
  static var identifier: String {get}
}

extension Identifiable {
  static var identifier: String {
    return String(describing: self)
  }
}
