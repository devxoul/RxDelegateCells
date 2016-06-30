//
//  RxTableViewSectionedReloadHeightDelegate.swift
//  SimpleTableViewController
//
//  Created by Suyeol Jeon on 6/29/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import UIKit

public class RxTableViewSectionedReloadHeightDelegate: RxTableViewSectionedHeightDelegate, RxTableViewHeightDelegateType {

    public func tableView(tableView: UITableView, observedCellHeights: [[CGFloat]]) {
        guard let visibleIndexPaths = tableView.indexPathsForVisibleRows else { return }
        for indexPath in visibleIndexPaths {
            if self.cellHeights[indexPath] != observedCellHeights[indexPath] {
                dispatch_async(dispatch_get_main_queue(), tableView.reloadData)
                break
            }
        }
        self.cellHeights = observedCellHeights
    }

    public func tableView(tableView: UITableView, observedHeaderHeights: [CGFloat]) {
        self.headerHeights = observedHeaderHeights
        dispatch_async(dispatch_get_main_queue(), tableView.reloadData)
    }

    public func tableView(tableView: UITableView, observedFooterHeights: [CGFloat]) {
        self.footerHeights = observedFooterHeights
        dispatch_async(dispatch_get_main_queue(), tableView.reloadData)
    }

}
