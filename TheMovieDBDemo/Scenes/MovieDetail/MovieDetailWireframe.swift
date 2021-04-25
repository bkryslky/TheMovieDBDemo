//
//  MovieDetailWireframe.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import UIKit

protocol MovieDetailWireframe {
    func toMovies()
    func toPersonDetail(person:Person)
}

class MovieDetailWireframeImp:MovieDetailWireframe{


    private let navigationController: UINavigationController
    private let endpoint: Endpoint
    
    init(endpoint: Endpoint,navigationController: UINavigationController) {
      self.endpoint = endpoint
      self.navigationController = navigationController
    }
    
   private func builder(movie:Movie) -> MovieDetailViewController {
        let viewModel = MovieDetailViewModel(endpoint: endpoint, wireframe: self)
        let vc = MovieDetailViewController.loadFromNib()
        vc.viewModel = viewModel
        vc.movie = movie
        return vc
    }
    
    func toMovieDetail(movie:Movie){
        navigationController.pushViewController(self.builder(movie:movie), animated: true)
    }
    
    func toMovies() {
      navigationController.popViewController(animated: true)
    }
    
    func toPersonDetail(person:Person){
        let personWireframe = PersonDetailWireframeImp(endpoint: endpoint, navigationController:navigationController)
        personWireframe.toPersonDetail(person: person)
    }
}
