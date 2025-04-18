//
//  TextFeedDetailViewController.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 18/04/25.
//

import UIKit

class TextFeedDetailViewController: FeedDetailViewController {

    let message = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        message.translatesAutoresizingMaskIntoConstraints = false
        message.lineBreakMode = .byWordWrapping
        message.numberOfLines = 0

        containerView.addSubview(message)

        NSLayoutConstraint.activate(
[
            message.topAnchor
                .constraint(equalTo: feedTitle.bottomAnchor, constant: Spacing.xl),
            message.trailingAnchor
                .constraint(
                    equalTo: containerView.trailingAnchor,
                    constant: -Spacing
                        .l),
            message.leadingAnchor
                .constraint(
                    equalTo: containerView.leadingAnchor,
                    constant: Spacing
                        .l),
        ]
)
    }

    override func configure(with feed: FeedModel) {
        super.configure(with: feed)
        guard let textFeed =  feed as? TextFeedModel else { return }
        message.text = textFeed.message
    }
}
