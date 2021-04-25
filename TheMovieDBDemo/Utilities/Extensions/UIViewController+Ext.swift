//
//  UIViewController+Ext.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import UIKit

extension UIViewController: Identifiable {}

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: T.identifier, bundle: nil)
        }
        
        return instantiateFromNib()
    }
    func loading(status:Bool) {
        if status{
            IndicatorView.sharedInstance.showIndicator()
        }else{
            IndicatorView.sharedInstance.hideIndicator()
        }
    }
}
