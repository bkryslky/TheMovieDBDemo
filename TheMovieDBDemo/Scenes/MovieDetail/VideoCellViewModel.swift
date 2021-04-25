//
//  VideoCellViewModel.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 24.04.2021.
//

import Foundation
class VideoCellViewModel {
    let name: String
    let video:Video
    
    init(with video: Video) {
        self.video = video
        self.name = video.name ?? ""
    }
}
