//
//  RxTableViewHeightDelegateType.swift
//  SimpleTableViewController
//
//  Created by Suyeol Jeon on 6/29/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import UIKit

public protocol RxTableViewHeightDelegateType /*: UITableViewDelegate*/ {
    func tableView(tableView: UITableView, observedCellHeights: [[CGFloat]])
    func tableView(tableView: UITableView, observedHeaderHeights: [CGFloat])
    func tableView(tableView: UITableView, observedFooterHeights: [CGFloat])
}
