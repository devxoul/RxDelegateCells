//
//  RxTableViewSectionedHeightDelegate.swift
//  SimpleTableViewController
//
//  Created by Suyeol Jeon on 6/29/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import UIKit

public class RxTableViewSectionedHeightDelegate: NSObject, UITableViewDelegate {

    var cellHeights: [[CGFloat]] = []
    var headerHeights: [CGFloat] = []
    var footerHeights: [CGFloat] = []

    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard 0..<self.cellHeights.count ~= indexPath.section &&
              0..<self.cellHeights[indexPath.section].count ~= indexPath.row
              else { return 44 }
        return self.cellHeights[indexPath.section][indexPath.row]
    }

    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if 0..<self.headerHeights.count ~= section {
            return self.headerHeights[section]
        }
        return tableView.sectionHeaderHeight
    }

    public func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if 0..<self.footerHeights.count ~= section {
            return self.footerHeights[section]
        }
        return tableView.sectionFooterHeight
    }

}
