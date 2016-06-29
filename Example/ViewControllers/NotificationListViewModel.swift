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

typealias NotificationListSectionModel = SectionModel<Void, NotificationCellModelType>

protocol NotificationListViewModelType {
    // Input
    var refreshControlDidChangeValue: PublishSubject<Void> { get }

    // Output
    var refreshControlRefreshing: Driver<Bool> { get }
    var sections: Driver<[NotificationListSectionModel]> { get }
    var cellHeights: Driver<[[Driver<CGFloat>]]> { get }
}

struct NotificationListViewModel: NotificationListViewModelType {

    // MARK: Input

    let refreshControlDidChangeValue: PublishSubject<Void> = PublishSubject()


    // MARK: Output

    let refreshControlRefreshing: Driver<Bool>
    let sections: Driver<[NotificationListSectionModel]>
    let cellHeights: Driver<[[Driver<CGFloat>]]>


    // MARK: Private

    private let _refreshControlRefreshing: PublishSubject<Bool>


    // MARK: Initializing

    init(api: API) {
        let cellModels = self.refreshControlDidChangeValue
            .flatMap { api.fetchNotificationList() }
            .map { notifications in
                notifications.map { NotificationCellModel(notification: $0) as NotificationCellModelType }
            }
            .asDriver(onErrorJustReturn: [])

        let _refreshControlRefreshing = PublishSubject<Bool>()
        self._refreshControlRefreshing = _refreshControlRefreshing
        self.refreshControlRefreshing = self._refreshControlRefreshing.asDriver(onErrorJustReturn: false)

        self.sections = cellModels
            .map { cellModels in
                [NotificationListSectionModel(model: Void(), items: cellModels)]
            }
            .doOnNext { _ in
                _refreshControlRefreshing.onNext(false)
            }

        self.cellHeights = cellModels.map { cellModels in
            [cellModels.map { $0.cellHeight }]
        }
    }
}
