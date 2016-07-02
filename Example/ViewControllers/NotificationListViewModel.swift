//
//  ViewModel.swift
//  RxDelegateCells
//
//  Created by Suyeol Jeon on 6/30/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift

typealias NotificationListSectionModel = SectionModel<Void, NotificationCellModel>

protocol NotificationListViewModelType {
    // Input
    var refreshControlDidChangeValue: PublishSubject<Void> { get }

    // Output
    var refreshControlRefreshing: Driver<Bool> { get }
    var sections: Driver<[NotificationListSectionModel]> { get }
}

struct NotificationListViewModel: NotificationListViewModelType {

    // MARK: Input

    let refreshControlDidChangeValue: PublishSubject<Void> = PublishSubject()


    // MARK: Output

    let refreshControlRefreshing: Driver<Bool>
    let sections: Driver<[NotificationListSectionModel]>

    // MARK: Initializing

    init(api: API) {
        let activityIndicator = ActivityIndicator()
        let cellModels = self.refreshControlDidChangeValue.asDriver(onErrorJustReturn: ())
            .flatMapLatest {
                api.fetchNotificationList()
                    .trackActivity(activityIndicator)
                    .asDriver(onErrorJustReturn: [])
            }
            .map { notifications in
                notifications.map { NotificationModel(notification: $0) as NotificationModelType }
            }

        self.refreshControlRefreshing = activityIndicator.asDriver()

        self.sections = cellModels
            .flatMapLatest { models -> Driver<[NotificationCellModel]> in
                models
                    .map { $0.message }
                    .combineLatest { $0.map(NotificationCellModel.init) }
            }
            .map { (cellModels: [NotificationCellModel]) in
                [NotificationListSectionModel(model: (), items: cellModels)]
            }
    }
}
