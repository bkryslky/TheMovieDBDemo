//
//  EndpointImp.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import Foundation
import RxSwift

class EndpointImp: Endpoint {
    
    func mostPopular() -> Observable<BaseResponse<[Content]>> {
        let method = EndpointRequestable.mostPopular
        return method.asURLRequest().perform()
    }
    
    func searchMulti(payload: SearchRequest) -> Observable<BaseResponse<[Content]>> {
        let method = EndpointRequestable.search(payload)
        return method.asURLRequest().perform()
    }
    
    func movieDetail(movieId: Int) -> Observable<MovieDetail> {
        let method = EndpointRequestable.movieDetail(movieId)
        return method.asURLRequest().perform()
    }
    
    func personDetail(personId: Int) -> Observable<PersonDetail> {
        let method = EndpointRequestable.personDetail(personId)
        return method.asURLRequest().perform()
    }

    
}
