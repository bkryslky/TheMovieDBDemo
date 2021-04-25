//
//  UITableView+Ext.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import UIKit

extension UITableView {
  func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UITableViewCell {
    guard let cell = dequeueReusableCell(withIdentifier: cellType.identifier,
                                         for: indexPath) as? T else {
      fatalError()
    }
    return cell
  }
  
  func register<T>(type: T.Type) where T: UITableViewCell {
    register(UINib(nibName: T.identifier, bundle: Bundle.main), forCellReuseIdentifier: T.identifier)
  }
}
