//
//  NotificationCell.swift
//  RxDelegateCells
//
//  Created by Suyeol Jeon on 6/30/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class NotificationCell: UITableViewCell {

    // MARK: Properties

    private var disposeBag: DisposeBag?


    // MARK: UI

    private var messageLabel = UILabel().then {
        $0.numberOfLines = 0
    }


    // MARK: Initializing

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.messageLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: Configuring

    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = nil
    }

    func configure(viewModel: NotificationCellModelType) {
        // Output
        self.messageLabel.attributedText = viewModel.message
    }


    // MARK: Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        self.messageLabel.top = 0
        self.messageLabel.left = 10
        self.messageLabel.width = self.contentView.width - 20
        self.messageLabel.height = self.height
    }

}
