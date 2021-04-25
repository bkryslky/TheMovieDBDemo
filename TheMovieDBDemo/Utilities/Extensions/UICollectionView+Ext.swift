//
//  UICollectionView+Ext.swift
//  TheMovieDBDemo
//
//  Created by Bekir Yeşilkaya on 18.04.2021.
//

import UIKit

extension UICollectionView {
  func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UICollectionViewCell {
    guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier,
                                         for: indexPath) as? T else {
      fatalError()
    }
    return cell
  }
  
  func register<T>(type: T.Type) where T: UICollectionViewCell {
    register(UINib(nibName: T.identifier, bundle: Bundle.main), forCellWithReuseIdentifier: T.identifier)
  }
  
  func registerSupplementaryView<T>(_: T.Type, ofKind kind: String)  where T: UICollectionReusableView {
    register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
  }
  
  func registerSupplementaryViewFromNib<T>(_: T.Type, ofKind kind: String) where T: UICollectionReusableView {
    let bundle = Bundle(for: T.self)
    let nib = UINib(nibName: T.identifier, bundle: bundle)
    register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
  }

  func dequeueSupplementaryView<T>(ofKind kind: String, `for` indexPath: IndexPath) -> T where T: UICollectionReusableView {
    guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
      fatalError("Could not dequeue supplementary view of kind: \(kind) with identifier: \(T.identifier)")
    }
    return view
  }
}
