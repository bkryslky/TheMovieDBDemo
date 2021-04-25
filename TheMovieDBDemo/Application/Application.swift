//
//  Application.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import UIKit
class Application {
  static let shared = Application()
  
  private let endpoint: Endpoint
  
  private init() {
    self.endpoint = EndpointImp()
  }
  
  func configureMainInterface(in window: UIWindow) {
    let navigationController = UINavigationController()
    navigationController.navigationBar.isHidden = true
    let wireframe = ContentsWireframeImp(endpoint: self.endpoint,
                                                navigationController: navigationController)
    window.rootViewController = navigationController
    wireframe.toContents()
  }
  
}
