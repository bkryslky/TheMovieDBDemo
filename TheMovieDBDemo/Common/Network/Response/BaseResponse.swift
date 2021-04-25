//
//  BaseResponse.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import Foundation
struct BaseResponse<T>: Codable where T: Codable {
    
    var data: T?
    var currentPage: Int?
    var totalPages: Int?
    var totalResults: Int?
    var errors: [String]?
    var statusMessage: String?
    var statusCode: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case data = "results"
        case currentPage = "page"
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case statusMessage = "status_message"
        case statusCode = "status_code"
        case errors
    }
}
