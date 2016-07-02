//
//  NotificationCellModel.swift
//  RxDelegateCells
//
//  Created by Krunoslav Zaher on 7/2/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import Foundation
import UIKit

protocol NotificationCellModelType {
    var message: NSAttributedString? { get }
}

struct NotificationCellModel: NotificationCellModelType {

    let message: NSAttributedString?

    init(message: NSAttributedString?) {
        self.message = message
    }
}

extension NotificationCellModel {
    func calculateCellHeight(cellWidth: CGFloat) -> CGFloat {
        let size = CGSize(width: cellWidth - 20, height: .max)
        let options: NSStringDrawingOptions = [.UsesLineFragmentOrigin, .UsesFontLeading]
        let rect = message?.boundingRectWithSize(size, options: options, context: nil) ?? .zero
        return ceil(rect.height) + 20
    }
}