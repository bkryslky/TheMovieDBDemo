//
//  URLRequest+Ext.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import Foundation
import Alamofire
import RxSwift

extension URLRequest {
  
  public func perform<T>() -> Observable<T> where T: Decodable {
    return AF.request(self).seralize().debug()
  }
  
}
