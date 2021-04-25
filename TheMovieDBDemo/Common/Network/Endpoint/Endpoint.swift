//
//  Endpoint.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import Foundation
import RxSwift

protocol Endpoint {
  
    func mostPopular() -> Observable<BaseResponse<[Content]>>
    func searchMulti(payload: SearchRequest) -> Observable<BaseResponse<[Content]>>
    func movieDetail(movieId: Int) -> Observable<MovieDetail>
    func personDetail(personId: Int) -> Observable<PersonDetail>

}
