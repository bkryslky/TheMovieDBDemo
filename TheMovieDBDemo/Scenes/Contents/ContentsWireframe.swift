//
//  ContentsWireframe.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import UIKit

protocol ContentsWireframe{
    func toContents()
    func toDetail(item: Content)
}

class ContentsWireframeImp:ContentsWireframe{
    
    private let navigationController: UINavigationController
    private let endpoint: Endpoint
    
    init(endpoint: Endpoint,
         navigationController: UINavigationController) {
      self.endpoint = endpoint
      self.navigationController = navigationController
    }
    
   private func builder() -> ContentsViewController {
        let vc = ContentsViewController.loadFromNib()
        vc.viewModel = ContentsViewModel(endpoint: endpoint, wireframe: self)
        return vc
    }
    
    func toContents() {
        navigationController.pushViewController(self.builder(), animated: true)
    }
    
    func toDetail(item: Content) {
        let wireframe = MovieDetailWireframeImp(endpoint: endpoint, navigationController: navigationController)
        wireframe.toMovieDetail(movie:item.toMovie())
    }
}
