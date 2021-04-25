//
//  MovieDetailViewModel.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel{
    
    private let wireframe: MovieDetailWireframe
    private let endpoint: Endpoint
    
    let disposeBag = DisposeBag()
    let viewWillAppear: PublishRelay<Void> = PublishRelay()
    let movieDetail:PublishSubject<MovieDetail> = PublishSubject()
    let casts: PublishSubject<[CastCellViewModel]> = PublishSubject()
    let videos: PublishSubject<[Video]> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    let selection:PublishSubject<Person> = PublishSubject()
    var movieId:Int?
    init(endpoint: Endpoint, wireframe: MovieDetailWireframe) {
        
        self.wireframe = wireframe
        self.endpoint = endpoint
        
        selection.subscribe { person in
            self.wireframe.toPersonDetail(person:person)
        }.disposed(by: disposeBag)
        
        self.viewWillAppear
            .catch { _ in Observable.never() }
            .map{ _ -> Int in
            return self.movieId ?? -1
        }.do(onNext: { id in
            self.loading.onNext(true)
        }).flatMap { id -> Observable<MovieDetail> in
            return self.endpoint.movieDetail(movieId:id)
        }.bind(to: movieDetail)
        .disposed(by: disposeBag)
    
    }
    
    
}
