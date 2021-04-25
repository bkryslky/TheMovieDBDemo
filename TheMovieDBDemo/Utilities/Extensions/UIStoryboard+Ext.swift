//
//  UIStoryboard+Ext.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import UIKit

extension UIStoryboard {
  func instantiateViewController<T>(ofType type: T.Type = T.self) -> T where T: UIViewController {
    guard let viewController = instantiateViewController(withIdentifier: type.identifier) as? T else {
      fatalError()
    }
    return viewController
  }
}
