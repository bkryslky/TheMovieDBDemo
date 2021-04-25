//
//  PersonDetailViewController.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

class PersonDetailViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var foregroundImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starringLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var tvsCollectionView: UICollectionView!
    
    var viewModel:PersonDetailViewModel!
    var person:Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMoviesCollectionView()
        setupTVsCollectionView()
        setupBindings()
    }
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupMoviesCollectionView(){
        moviesCollectionView.register(type: MovieCollectionViewCell.self)
       
        let w:CGFloat = 120
        let h:CGFloat = 240
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: w, height: h)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
      
    
        moviesCollectionView.collectionViewLayout = layout
        moviesCollectionView.backgroundColor = .clear
    
    }
    
    private func setupTVsCollectionView(){
        tvsCollectionView.register(type: TVsCollectionViewCell.self)
       
        let w:CGFloat = 120
        let h:CGFloat = 240
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: w, height: h)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
      
    
        tvsCollectionView.collectionViewLayout = layout
        tvsCollectionView.backgroundColor = .clear
    
    }
    
    private func setupBindings(){
      
        
        viewModel.loading.subscribe {[weak self] event in
            self?.loading(status: event.element ?? false)
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.personDetail
            .bind(to: postBinding)
            .disposed(by: viewModel.disposeBag)
        
        viewModel.personDetail.map { item -> [MovieCellViewModel] in
            return item.knownFor?.map({ movie -> MovieCellViewModel in
              return MovieCellViewModel(with: movie)
            }) ?? []
        }.do(onNext: {[weak self] _ in
            self?.viewModel.loading.onNext(false)
        }).bind(to: moviesCollectionView.rx.items(cellIdentifier: MovieCollectionViewCell.identifier, cellType: MovieCollectionViewCell.self)) { row, viewModel, cell in
            cell.bind(viewModel)
        }.disposed(by: viewModel.disposeBag)
        
        //MARK: TODO
        //TVs will make later...
        
//        viewModel.personDetail.do(onNext: {[weak self] _ in
//            guard let self = self else {return}
//            self.viewModel.loading.onNext(false)
//        }).map({ movie -> [Video] in
//            return movie.videos?.data ?? []
//        }).map { item -> [VideoCellViewModel] in
//            return item.map { video -> VideoCellViewModel in
//                return VideoCellViewModel(with: video)
//            }
//        }.bind(to: tvsCollectionView.rx.items(cellIdentifier: TVsCollectionViewCell.identifier, cellType: TVsCollectionViewCell.self)) {[weak self] row, viewModel, cell in
//            guard let self = self else {return}
//
//            cell.imageView.kf.setImage(with:profileImageURL)
//
//        }.disposed(by: viewModel.disposeBag)
        
        rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
          .map {[weak self] _ in
            guard let self = self else {return}
            self.viewModel.personId = self.person.id
          }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: viewModel.disposeBag)
    }
    
    var postBinding: Binder<PersonDetail> {
      return Binder(self, binding: { (vc, person) in
        vc.nameLabel.text = person.name
        vc.summaryLabel.text = person.biography
        vc.starringLabel.text = person.knownForDepartment
        vc.backgroundImageView.kf.setImage(with: person.profileImageURL)
        vc.foregroundImageView.kf.setImage(with: person.profileImageURL)
      })
    }

}
