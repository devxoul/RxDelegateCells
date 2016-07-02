//
//  NotificationCellModel.swift
//  RxDelegateCells
//
//  Created by Suyeol Jeon on 6/30/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import RxCocoa
import RxSwift

protocol NotificationModelType {
    var message: Driver<NSAttributedString?> { get }
}

struct NotificationModel: NotificationModelType {

    let message: Driver<NSAttributedString?>

    init(notification: Notification) {
        self.message = Driver.just(notification.message)
    }
}

