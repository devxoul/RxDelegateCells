//
//  NotificationCellModel.swift
//  RxDelegateCells
//
//  Created by Suyeol Jeon on 6/30/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import RxCocoa
import RxSwift

protocol NotificationCellModelType {
    var cellWidth: Variable<CGFloat> { get }
    var cellHeight: Driver<CGFloat> { get }
    var message: Driver<NSAttributedString?> { get }
}

struct NotificationCellModel: NotificationCellModelType {

    let cellWidth: Variable<CGFloat> = Variable(0)
    let cellHeight: Driver<CGFloat>
    let message: Driver<NSAttributedString?>

    init(notification: Notification) {
        self.message = Driver.just(notification.message)
        self.cellHeight = Observable
            .combineLatest(self.cellWidth.asObservable(), self.message.asObservable()) { ($0, $1) }
            .map { cellWidth, message in
                let size = CGSize(width: cellWidth - 20, height: .max)
                let options: NSStringDrawingOptions = [.UsesLineFragmentOrigin, .UsesFontLeading]
                let rect = message?.boundingRectWithSize(size, options: options, context: nil) ?? .zero
                return ceil(rect.height) + 20
            }
            .asDriver(onErrorJustReturn: 0)
    }

}
