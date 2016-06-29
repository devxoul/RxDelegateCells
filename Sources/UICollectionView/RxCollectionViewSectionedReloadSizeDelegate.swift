//
//  RxCollectionViewSectionedReloadSizeDelegate.swift
//  SimpleTableViewController
//
//  Created by Suyeol Jeon on 6/29/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import UIKit

public class RxCollectionViewSectionedReloadSizeDelegate: RxCollectionViewSectionedSizeDelegate, RxCollectionViewSizeDelegateType {

    public func collectionView(collectionView: UICollectionView, observedCellSizes: [[CGSize]]) {
        self.cellSizes = observedCellSizes
        collectionView.reloadData()
    }

    public func collectionView(collectionView: UICollectionView, observedHeaderReferenceSizes: [CGSize]) {
        self.headerReferenceSizes = observedHeaderReferenceSizes
        collectionView.reloadData()
    }

    public func collectionView(collectionView: UICollectionView, observedFooterReferenceSizes: [CGSize]) {
        self.footerReferenceSizes = observedFooterReferenceSizes
        collectionView.reloadData()
    }

}
