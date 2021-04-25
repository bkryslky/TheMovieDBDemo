//
//  ContentsViewModel.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import Foundation
import RxSwift
import RxCocoa


class ContentsViewModel{
    
    private let wireframe: ContentsWireframe
    private let endpoint: Endpoint
    
    let disposeBag: DisposeBag = DisposeBag()
    let contents: PublishRelay<[Content]> = PublishRelay()
    let loading: PublishSubject<Bool> = PublishSubject()
    let query: PublishSubject<String> = PublishSubject()
    let queryContents: PublishRelay<[Content]> = PublishRelay()
    let selection:PublishSubject<Content> = PublishSubject()
    let viewWillAppear:PublishRelay<Void> =  PublishRelay()

    init(endpoint: Endpoint, wireframe: ContentsWireframe) {
      self.endpoint = endpoint
      self.wireframe = wireframe
        
        
        selection.subscribe { content in
            self.wireframe.toDetail(item: content)
        }.disposed(by: disposeBag)
        
        query.throttle(DispatchTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .do(onNext: { query in
              if query.count < 2 {
                self.contents.accept([])
                self.loading.onNext(false)
              }
            })
            .filter { query -> Bool in
              return query.count > 1
            }
            .map { query in
                return SearchRequest(query: query, page: 1)
            }
            .do(onNext: { query in
                self.loading.onNext(true)
            })
            .concatMap { requestEntity in
                return self.endpoint.searchMulti(payload: requestEntity)
              }
            .map { response -> [Content] in
                let data = response.data ?? []
                return data
              }
            .do(onNext: { data in
                self.loading.onNext(false)
              })
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.asyncInstance)
            .bind(to: queryContents)
            .disposed(by: disposeBag)
              
        viewWillAppear.do { _ in
            self.loading.onNext(true)
        }.flatMap { _  -> Observable<BaseResponse<[Content]>> in
            return endpoint.mostPopular()
        }.catch { _ in Observable.never() }
        .map{ base -> [Content] in
            let data = base.data ?? []
            return data
        }.do(onNext: { _ in
            self.loading.onNext(false)
        })
        .bind(to:contents)
        .disposed(by: disposeBag)

    }
    

}
