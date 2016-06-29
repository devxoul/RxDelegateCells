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
        self.cellHeights = observedCellHeights
        dispatch_async(dispatch_get_main_queue(), tableView.reloadData)
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
