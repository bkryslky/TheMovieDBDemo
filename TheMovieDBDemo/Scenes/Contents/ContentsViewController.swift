//
//  ContentsViewController.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class ContentsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel:ContentsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSearchBar()
        setupBindings()
       
    }
    
    private func setupSearchBar(){
        searchBar.placeholder = "Search..."
        searchBar.showsCancelButton = true
    }
    
    private func setupCollectionView(){
        collectionView.register(type: ContentCollectionViewCell.self)
       
        let w:CGFloat = UIScreen.main.bounds.width - 30
        let h:CGFloat = 190
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: w, height: h)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
      
    
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
    
    }
    
    private func setupBindings(){
    
        searchBar.rx
            .text
            .orEmpty
            .bind(to: viewModel.query)
            .disposed(by: viewModel.disposeBag)
        
        searchBar
          .rx
          .searchButtonClicked
          .subscribe { _ in
            if self.searchBar.isFirstResponder {
              self.searchBar.resignFirstResponder()
            }
          }.disposed(by: viewModel.disposeBag)
        

        searchBar.rx.cancelButtonClicked.subscribe { _ in
            self.searchBar.text = nil
            if self.searchBar.isFirstResponder {
              self.searchBar.resignFirstResponder()
            }
            self.segmentControl.isHidden = true
            self.titleLabel.isHidden = false
            self.viewModel.viewWillAppear.accept(())
        }.disposed(by: viewModel.disposeBag)

        viewModel.queryContents.do(onNext: { _ in
            self.segmentControl.isHidden = false
            self.titleLabel.isHidden = true
            
        }).bind(to: viewModel.contents).disposed(by: viewModel.disposeBag)
        
        segmentControl.rx.selectedSegmentIndex.map { index -> MediaType in
            switch index{
            case 1: return .person
            case 2: return .tv
            default: return .movie
            }
        }.do(onNext: { type in
            
        }).flatMap{ type -> Observable<[Content]> in
            return self.viewModel.queryContents.map { c -> [Content] in
               c.filter({$0.mediaType == type})
           }
        }
        .bind(to: self.viewModel.contents).disposed(by: viewModel.disposeBag)
        
        let selection = collectionView.rx.modelSelected(Content.self)
        selection.bind(to: viewModel.selection).disposed(by: viewModel.disposeBag)
        
        viewModel.loading.subscribe {[weak self] event in
            self?.loading(status: event.element ?? false)
        }.disposed(by: viewModel.disposeBag)
       
        viewModel.contents.bind(to:collectionView.rx.items(cellIdentifier:ContentCollectionViewCell.identifier,cellType: ContentCollectionViewCell.self)){ index,model,cell in
            cell.titleLabel.text = model.name
            cell.detailLabel.text = model.overview
            cell.imageView.layer.cornerRadius = 15.0
            cell.bgView.layer.cornerRadius = 15.0
            if let url = model.posterImageURL{
                cell.imageView.kf.setImage(with:url)
            }
            }.disposed(by: viewModel.disposeBag)
        
        rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map { _ in}
            .do(onNext: { _ in
                self.segmentControl.isHidden = true
            })
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: viewModel.disposeBag)
    
    }

}
