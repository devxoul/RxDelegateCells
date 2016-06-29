//
//  RxCollectionViewSectionedSizeDelegate.swift
//  SimpleTableViewController
//
//  Created by Suyeol Jeon on 6/29/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import UIKit

public class RxCollectionViewSectionedSizeDelegate: NSObject, UICollectionViewDelegateFlowLayout {

    var cellSizes: [[CGSize]] = []
    var headerReferenceSizes: [CGSize] = []
    var footerReferenceSizes: [CGSize] = []

    public func collectionView(collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        guard 0..<self.cellSizes.count ~= indexPath.section &&
              0..<self.cellSizes[indexPath.section].count ~= indexPath.item
              else { return (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize ?? .zero }
        return self.cellSizes[indexPath.section][indexPath.item]
    }

    public func collectionView(collectionView: UICollectionView,
                layout collectionViewLayout: UICollectionViewLayout,
                referenceSizeForFooterInSection section: Int) -> CGSize {
        if 0..<self.headerReferenceSizes.count ~= section {
            return self.headerReferenceSizes[section]
        }
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.headerReferenceSize ?? .zero
    }

    public func collectionView(collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               referenceSizeForHeaderInSection section: Int) -> CGSize {
        if 0..<self.footerReferenceSizes.count ~= section {
            return self.footerReferenceSizes[section]
        }
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize ?? .zero
    }

}
