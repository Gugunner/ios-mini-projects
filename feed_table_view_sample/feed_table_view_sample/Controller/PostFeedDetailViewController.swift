//
//  PostFeedDetailViewController.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 18/04/25.
//

import UIKit

class PostFeedDetailViewController: FeedDetailViewController {

    let imageView = FeedImageView()
    let feedDescription = UILabel()


    override func viewDidLoad() {
        super.viewDidLoad()
        feedDescription.translatesAutoresizingMaskIntoConstraints = false
        feedDescription.numberOfLines = 0
        feedDescription.textAlignment = .justified
        feedDescription.lineBreakMode = .byWordWrapping

        imageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(feedDescription)
        view.addSubview(imageView)

        NSLayoutConstraint.activate(
[
            feedDescription.topAnchor
                .constraint(equalTo: feedTitle.bottomAnchor, constant: Spacing.xl),
            feedDescription.trailingAnchor
                .constraint(
                    equalTo: containerView.trailingAnchor,
                    constant: -Spacing
                        .l),
            feedDescription.leadingAnchor
                .constraint(
                    equalTo: containerView.leadingAnchor,
                    constant: Spacing
                        .l),

            imageView.topAnchor
                .constraint(
                    equalTo: feedDescription.bottomAnchor,
                    constant: Spacing
                        .xl),
            imageView.trailingAnchor
                .constraint(
                    equalTo: containerView.trailingAnchor,
                    constant: -Spacing.l
                ),
            imageView.bottomAnchor
                .constraint(equalTo: createdAt.topAnchor, constant: -Spacing.xl),
            imageView.leadingAnchor
                .constraint(
                    equalTo: containerView.leadingAnchor,
                    constant: Spacing
                        .l),
        ]
)
    }

    override func configure(with feed: FeedModel) {
        super.configure(with: feed)
        guard let postFeed = feed as? PostFeedModel else { return }
        feedDescription.text = postFeed.description
        imageView.configureImageFrom(name: postFeed.imagePath)
    }
}
