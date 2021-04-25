//
//  MovieDetailViewController.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import UIKit
import Cosmos
import RxCocoa
import RxSwift

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var foregroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var videosCollectionView: UICollectionView!
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    var viewModel:MovieDetailViewModel!
    var movie:Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCastCollectionView()
        setupVideoCollectionView()
        setupBindings()
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupCastCollectionView(){
        castCollectionView.register(type: CastCollectionViewCell.self)
        
        let w:CGFloat = 120
        let h:CGFloat = 240
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: w, height: h)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        
        castCollectionView.collectionViewLayout = layout
        castCollectionView.backgroundColor = .clear
        
    }
    
    private func setupVideoCollectionView(){
        videosCollectionView.register(type: VideoCollectionViewCell.self)
        
        let w:CGFloat = 180
        let h:CGFloat = 150
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: w, height: h)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        
        videosCollectionView.collectionViewLayout = layout
        videosCollectionView.backgroundColor = .clear
        
    }
    
    private func setupBindings(){
        
        
        viewModel.loading.subscribe {[weak self] event in
            self?.loading(status: event.element ?? false)
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.movieDetail
            .bind(to: postBinding)
            .disposed(by: viewModel.disposeBag)
        
        let selection = castCollectionView.rx.modelSelected(CastCellViewModel.self)
        selection
            .flatMap{ cvm -> Observable<Person> in
                return Observable.create { observer -> Disposable in
                    observer.onNext(Person(id: cvm.cast.id!, name: cvm.cast.name, profilePath: nil, popularity: nil, knownFor: nil))
                    observer.onCompleted()
                    return Disposables.create()
                }
                
            }.bind(to: viewModel.selection)
            .disposed(by: viewModel.disposeBag)
        
        viewModel.movieDetail.map { item -> [CastCellViewModel] in
            return item.credits?.cast?.map({ cast -> CastCellViewModel in
                return CastCellViewModel(with: cast)
            }) ?? []
        }.bind(to: castCollectionView.rx.items(cellIdentifier: CastCollectionViewCell.identifier, cellType: CastCollectionViewCell.self)) { row, viewModel, cell in
            cell.bind(viewModel)
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.movieDetail.do(onNext: {[weak self] _ in
            guard let self = self else {return}
            self.viewModel.loading.onNext(false)
        }).map({ movie -> [Video] in
            return movie.videos?.data ?? []
        }).map { item -> [VideoCellViewModel] in
            return item.map { video -> VideoCellViewModel in
                return VideoCellViewModel(with: video)
            }
        }.bind(to: videosCollectionView.rx.items(cellIdentifier: VideoCollectionViewCell.identifier, cellType: VideoCollectionViewCell.self)) {[weak self] row, viewModel, cell in
            guard let self = self else {return}
            var profileImageURL: URL? {
                if let path = self.movie.posterPath {
                    return URL(string: "\(Constants.API.ImageBaseURL)\(path)")
                }
                return nil
            }
            cell.imageView.kf.setImage(with:profileImageURL)
            cell.bind(viewModel)
        }.disposed(by: viewModel.disposeBag)
        
        rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map {[weak self] _ in
                guard let self = self else {return}
                self.viewModel.movieId = self.movie.id
            }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: viewModel.disposeBag)
    }
    
    var postBinding: Binder<MovieDetail> {
        return Binder(self, binding: { (vc, movie) in
            vc.titleLabel.text = movie.title
            vc.summaryLabel.text = movie.overview
            vc.backgroundImageView.kf.setImage(with: movie.posterImageURL)
            vc.foregroundImageView.kf.setImage(with: movie.posterImageURL)
            vc.ratingView.rating = movie.voteAverage ?? 0.0
        })
    }
}
