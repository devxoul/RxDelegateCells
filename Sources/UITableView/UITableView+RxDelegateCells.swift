//
//  UITableView+RxCellHeight.swift
//  SimpleTableViewController
//
//  Created by Suyeol Jeon on 6/29/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

public extension UITableView {

    public func rx_cellHeightWithDelegate<Delegate: protocol<RxTableViewHeightDelegateType, UITableViewDelegate>,
                                          O: ObservableType where O.E == [[Driver<CGFloat>]]>
                                         (delegate: Delegate) -> (source: O) -> Disposable {
        return { source in
            return source
                // converts `Driver<[[Driver<CGFloat>]]>` to `Driver<[[CGFloat]]>`
                .flatMap { sections -> Driver<[[CGFloat]]> in
                    sections.map { rows in
                        rows.combineLatest { $0 }
                    }.combineLatest { $0 }
                }
                .distinctUntilChanged { $0 == $1 }
                .subscribeProxyDelegateForObject(self, delegate: delegate, retainDelegate: false) {
                    [weak self] (_: RxTableViewDelegateProxy, cellHeights) -> Void in
                    guard let tableView = self else { return }
                    delegate.tableView(tableView, observedCellHeights: cellHeights)
                }
        }
    }

    public func rx_headerHeightWithDelegate<Delegate: protocol<RxTableViewHeightDelegateType, UITableViewDelegate>,
                                            O: ObservableType where O.E == [Driver<CGFloat>]>
                                           (delegate: Delegate) -> (source: O) -> Disposable {
        return { source in
            return source
                // converts `Driver<[Driver<CGFloat>]>` to `Driver<[CGFloat]>`
                .flatMap { sections -> Driver<[CGFloat]> in
                    sections.map { $0 }.combineLatest { $0 }
                }
                .distinctUntilChanged { $0 == $1 }
                .subscribeProxyDelegateForObject(self, delegate: delegate, retainDelegate: false) {
                    [weak self] (_: RxTableViewDelegateProxy, headerHeights) -> Void in
                    guard let tableView = self else { return }
                    delegate.tableView(tableView, observedHeaderHeights: headerHeights)
                }
        }
    }

    public func rx_footerHeightWithDelegate<Delegate: protocol<RxTableViewHeightDelegateType, UITableViewDelegate>,
                                            O: ObservableType where O.E == [Driver<CGFloat>]>
                                           (delegate: Delegate) -> (source: O) -> Disposable {
        return { source in
            return source
                // converts `Driver<[Driver<CGFloat>]>` to `Driver<[CGFloat]>`
                .flatMap { sections -> Driver<[CGFloat]> in
                    sections.map { $0 }.combineLatest { $0 }
                }
                .distinctUntilChanged { $0 == $1 }
                .subscribeProxyDelegateForObject(self, delegate: delegate, retainDelegate: false) {
                    [weak self] (_: RxTableViewDelegateProxy, footerHeights) -> Void in
                    guard let tableView = self else { return }
                    delegate.tableView(tableView, observedFooterHeights: footerHeights)
                }
        }
    }

}
