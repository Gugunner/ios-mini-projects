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

        NSLayoutConstraint.activate([
            message.topAnchor
                .constraint(equalTo: feedTitle.bottomAnchor, constant: 20),
            message.trailingAnchor
                .constraint(equalTo: containerView.trailingAnchor, constant: -16),
            message.leadingAnchor
                .constraint(equalTo: containerView.leadingAnchor, constant: 16),
        ])
    }

    override func configure(with feed: FeedModel) {
        super.configure(with: feed)
        if let textFeed = feed as? TextFeedModel {
            message.text = textFeed.message
        }
    }

}
