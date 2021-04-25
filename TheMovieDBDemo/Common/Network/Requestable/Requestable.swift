//
//  Requestable.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import Foundation
import Alamofire

protocol Requestable {
  
  var path: String { get }
  var headers: [String: String] { get }
  var method: HTTPMethod { get }
  var extraParams: [String : Any]? { get }
}

extension Requestable {
  
  var baseURL: String {
    return Constants.API.BaseURL
  }
  
  var apiKey: String {
    return Constants.API.APIKey
  }
  
  var version: String {
    return "/3"
  }
  
  var headers: [String : String] {
    return [:]
  }
  
  var additionalParams: [String : Any] {
    return ["language": "en",
            "include_adult": true,
            "api_key": apiKey]
  }
  
  var urlComponents: URLComponents {
    guard var components = URLComponents(string: baseURL) else {
      fatalError("URLComponents cannot be created")
    }
    components.path = version + path

    var queryItems: [URLQueryItem] = []

    let params = additionalParams.map({ (key, value) -> URLQueryItem in
      return URLQueryItem(name: "\(key)", value: "\(value)")
    })
    
    let extraParameters = extraParams?.map({ (key, value) -> URLQueryItem in
      return URLQueryItem(name: "\(key)", value: "\(value)")
    })

    queryItems.append(contentsOf: params)
    queryItems.append(contentsOf: extraParameters ?? [])

    components.queryItems = queryItems
    return components
  }
  
  
}
