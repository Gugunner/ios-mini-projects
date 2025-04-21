//
//  PostFeedTableViewCell.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 16/04/25.
//

import UIKit

class PostFeedTableViewCell: FeedTableViewCell {

    let contentImageView = FeedImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpImageView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpImageView()
    }

    private func setUpImageView() {
        containerView.addSubview(contentImageView)
        NSLayoutConstraint.activate(
[
            // MARK: - Padding
            contentImageView.topAnchor
                .constraint(equalTo: title.bottomAnchor, constant: Spacing.s),
            contentImageView.trailingAnchor
                .constraint(equalTo: title.trailingAnchor),
            contentImageView.leadingAnchor
                .constraint(equalTo: title.leadingAnchor),
            contentImageView.bottomAnchor
                .constraint(
                    equalTo: containerView.bottomAnchor,
                    constant: -Spacing
                        .l),
        ]
)
    }

    override func configure(with feed: FeedModel) {
        super.configure(with: feed)
        guard let postFeed = feed as? PostFeedModel else { return }
        contentImageView.configureImageFrom(name: postFeed.imagePath)
    }
}
