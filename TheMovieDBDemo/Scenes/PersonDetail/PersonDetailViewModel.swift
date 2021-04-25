//
//  PersonDetailViewModel.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import Foundation
import RxSwift
import RxCocoa

class PersonDetailViewModel{
    
    private let wireframe: PersonDetailWireframe
    private let endpoint: Endpoint
    
    let disposeBag = DisposeBag()
    let viewWillAppear: PublishRelay<Void> = PublishRelay()
    let personDetail:PublishSubject<PersonDetail> = PublishSubject()
    let casts: PublishSubject<[CastCellViewModel]> = PublishSubject()
    let videos: PublishSubject<[Video]> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    var personId:Int?
   
    init(endpoint: Endpoint, wireframe: PersonDetailWireframe) {
      self.wireframe = wireframe
      self.endpoint = endpoint
        
        self.viewWillAppear
            .catch { _ in Observable.never() }
            .map{ _ -> Int in
            return self.personId ?? -1
        }.do(onNext: { id in
            self.loading.onNext(true)
        }).flatMap { id -> Observable<PersonDetail> in
            return self.endpoint.personDetail(personId:id)
        }.bind(to: personDetail)
        .disposed(by: disposeBag)
    }
    
}
