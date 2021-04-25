//
//  PersonDetailWireframe.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import UIKit

protocol PersonDetailWireframe{
    func toPersonDetail(person:Person)
    func toPersons()
}

class PersonDetailWireframeImp:PersonDetailWireframe{
 
    private let navigationController: UINavigationController
    private let endpoint: Endpoint
    
    init(endpoint: Endpoint,navigationController: UINavigationController) {
      self.endpoint = endpoint
      self.navigationController = navigationController
    }
    
    private  func builder(person:Person) -> PersonDetailViewController {
        let viewModel = PersonDetailViewModel(endpoint: endpoint, wireframe: self)
        let vc = PersonDetailViewController.loadFromNib()
        vc.viewModel = viewModel
        vc.person = person
        return vc
        
    }
    
    func toPersonDetail(person: Person) {
        navigationController.pushViewController(self.builder(person: person), animated: true)
    }
    
    func toPersons() {
      navigationController.popViewController(animated: true)
    }
}
