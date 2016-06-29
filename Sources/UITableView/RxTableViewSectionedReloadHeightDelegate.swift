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
        tableView.reloadData()
    }

    public func tableView(tableView: UITableView, observedHeaderHeights: [CGFloat]) {
        self.headerHeights = observedHeaderHeights
        tableView.reloadData()
    }

    public func tableView(tableView: UITableView, observedFooterHeights: [CGFloat]) {
        self.footerHeights = observedFooterHeights
        tableView.reloadData()
    }

}
