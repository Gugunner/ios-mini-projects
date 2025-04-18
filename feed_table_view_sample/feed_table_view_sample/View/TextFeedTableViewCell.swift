//
//  TextFeedTableViewCell.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 16/04/25.
//

import UIKit

class TextFeedTableViewCell: FeedTableViewCell {

    let message = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupMessage()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupMessage()
    }

    private func setupMessage() {
        message.translatesAutoresizingMaskIntoConstraints = false
        message.lineBreakMode = .byWordWrapping
        message.numberOfLines = 0
        containerView.addSubview(message)

        NSLayoutConstraint.activate(
[
            // MARK: - Paddings
            message.topAnchor
                .constraint(equalTo: title.bottomAnchor, constant: Spacing.s),
            message.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            message.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            message.bottomAnchor
                .constraint(
                    equalTo: containerView.bottomAnchor,
                    constant: -Spacing
                        .s)
        ]
)
    }

    override func configure(with feed: FeedModel) {
        super.configure(with: feed)
        guard let textFeed = feed as? TextFeedModel else { return }
        message.text = textFeed.message
    }
}
