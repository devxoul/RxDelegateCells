//
//  ViewController.swift
//  Example
//
//  Created by Suyeol Jeon on 6/30/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import UIKit

import RxCocoa
import RxDataSources
import RxDelegateCells
import RxSwift
import SnapKit

class NotificationListViewController: UIViewController {

    // MARK: Properties

    private let disposeBag = DisposeBag()

    let refreshControl = UIRefreshControl()
    let tableView = UITableView().then {
        $0.registerClass(NotificationCell.self, forCellReuseIdentifier: "NotificationCell")
    }


    // MARK: Initializing

    init(viewModel: NotificationListViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.title = "Notifications"
        self.configure(viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addSubview(self.refreshControl)
        self.view.addSubview(self.tableView)

        self.tableView.snp_makeConstraints { make in
            make.edges.equalTo(0)
        }

        self.refreshControl.sendActionsForControlEvents(.ValueChanged)
    }


    // MARK: Configuring

    private func configure(viewModel: NotificationListViewModelType) {
        let dataSource = RxTableViewSectionedReloadDataSource<NotificationListSectionModel>()
        let delegate = RxTableViewSectionedReloadHeightDelegate()

        dataSource.configureCell = { _, tableView, indexPath, viewModel in
            let cell = tableView.dequeueReusableCellWithIdentifier("NotificationCell") as! NotificationCell
            cell.configure(viewModel)
            return cell
        }

        // Input
        self.refreshControl.rx_controlEvent(.ValueChanged)
            .bindTo(viewModel.refreshControlDidChangeValue)
            .addDisposableTo(self.disposeBag)

        // Output
        viewModel.refreshControlRefreshing
            .drive(self.refreshControl.rx_refreshing)
            .addDisposableTo(self.disposeBag)

        viewModel.sections
            .drive(self.tableView.rx_itemsWithDataSource(dataSource))
            .addDisposableTo(self.disposeBag)

        viewModel.cellHeights
            .drive(self.tableView.rx_cellHeightWithDelegate(delegate))
            .addDisposableTo(self.disposeBag)
    }

}
