//
//  RxCollectionViewSizeDelegateType.swift
//  SimpleTableViewController
//
//  Created by Suyeol Jeon on 6/29/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import UIKit

public protocol RxCollectionViewSizeDelegateType /*: UICollectionViewDelegateFlowLayout*/ {
    func collectionView(collectionView: UICollectionView, observedCellSizes: [[CGSize]])
    func collectionView(collectionView: UICollectionView, observedHeaderReferenceSizes: [CGSize])
    func collectionView(collectionView: UICollectionView, observedFooterReferenceSizes: [CGSize])
}
