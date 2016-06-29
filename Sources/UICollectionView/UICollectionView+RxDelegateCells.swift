//
//  UICollectionView+RxSizeDelegate.swift
//  SimpleTableViewController
//
//  Created by Suyeol Jeon on 6/29/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

public extension UICollectionView {

    public func rx_cellSizeWithDelegate<Delegate: protocol<RxCollectionViewSizeDelegateType, UICollectionViewDelegateFlowLayout>,
                                        O: ObservableType where O.E == [[Driver<CGSize>]]>
                                       (delegate: Delegate) -> (source: O) -> Disposable {
        return { source in
            return source
                // converts `Driver<[[Driver<CGSize>]]>` to `Driver<[[CGSize]]>`
                .flatMap { sections -> Driver<[[CGSize]]> in
                    sections.map { rows in
                        rows.combineLatest { $0 }
                    }.combineLatest { $0 }
                }
                .distinctUntilChanged { $0 == $1 }
                .subscribeProxyDelegateForObject(self, delegate: delegate, retainDelegate: false) {
                    [weak self] (_: RxCollectionViewDelegateProxy, cellSizes) -> Void in
                    guard let collectionView = self else { return }
                    delegate.collectionView(collectionView, observedCellSizes: cellSizes)
                }
        }
    }

    public func rx_headerReferenceSizeWithDelegate<Delegate: protocol<RxCollectionViewSizeDelegateType, UICollectionViewDelegateFlowLayout>,
                                        O: ObservableType where O.E == [Driver<CGSize>]>
                                       (delegate: Delegate) -> (source: O) -> Disposable {
        return { source in
            return source
                // converts `Driver<[Driver<CGSize>]>` to `Driver<[CGSize]>`
                .flatMap { sections -> Driver<[CGSize]> in
                    sections.map { $0 }.combineLatest { $0 }
                }
                .distinctUntilChanged { $0 == $1 }
                .subscribeProxyDelegateForObject(self, delegate: delegate, retainDelegate: false) {
                    [weak self] (_: RxCollectionViewDelegateProxy, headerReferenceSizes) -> Void in
                    guard let collectionView = self else { return }
                    delegate.collectionView(collectionView, observedHeaderReferenceSizes: headerReferenceSizes)
                }
        }
    }

    public func rx_footerReferenceSizeWithDelegate<Delegate: protocol<RxCollectionViewSizeDelegateType, UICollectionViewDelegateFlowLayout>,
                                        O: ObservableType where O.E == [Driver<CGSize>]>
                                       (delegate: Delegate) -> (source: O) -> Disposable {
        return { source in
            return source
                // converts `Driver<[Driver<CGSize>]>` to `Driver<[CGSize]>`
                .flatMap { sections -> Driver<[CGSize]> in
                    sections.map { $0 }.combineLatest { $0 }
                }
                .distinctUntilChanged { $0 == $1 }
                .subscribeProxyDelegateForObject(self, delegate: delegate, retainDelegate: false) {
                    [weak self] (_: RxCollectionViewDelegateProxy, footerReferenceSizes) -> Void in
                    guard let collectionView = self else { return }
                    delegate.collectionView(collectionView, observedFooterReferenceSizes: footerReferenceSizes)
                }
        }
    }

}

private func == (lhs: [[CGSize]], rhs: [[CGSize]]) -> Bool {
    for l in lhs {
        for r in rhs {
            if l != r {
                return false
            }
        }
    }
    return true
}
