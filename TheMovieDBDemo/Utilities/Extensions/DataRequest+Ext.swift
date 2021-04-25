//
//  DataRequest+Ext.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import Foundation
import Alamofire
import RxSwift

extension DataRequest {
  
  @discardableResult
  public func seralize<T: Decodable>(completionHandler: @escaping (AFDataResponse<T>) -> Void) -> Self {
    responseJSON { data in
        switch data.result{
        case .success(let json):
            print(json)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    return responseDecodable(completionHandler: completionHandler)
  }
  
  public func seralize<T: Decodable>() -> Observable<T> {
    return Observable.create { observer in

      let request = self.seralize { (data: AFDataResponse<T>) in
        switch data.result {
        case .success(let payload):
        
            observer.onNext(payload)
          break
        case .failure(let error):
            
            observer.onError(error)
           
          break
        }
        observer.onCompleted()
      }
      
      return Disposables.create {
        request.cancel()
      }
    }
  }
}
