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
        setUpViews()
    }

    override func configure(with feed: FeedModel) {
        super.configure(with: feed)
        guard let postFeed = feed as? PostFeedModel else { return }
        feedDescription.text = postFeed.description
        imageView.configureImageFrom(name: postFeed.imagePath)
    }
}

extension PostFeedDetailViewController {
    private func setUpViews() {
        feedDescription.translatesAutoresizingMaskIntoConstraints = false
        feedDescription.numberOfLines = 0
        feedDescription.textAlignment = .justified
        feedDescription.lineBreakMode = .byWordWrapping
        feedDescription.textColor = .label

        imageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(feedDescription)
        view.addSubview(imageView)
        NSLayoutConstraint.activate(
[
            feedDescription.topAnchor
                .constraint(equalTo: feedTitle.bottomAnchor, constant: Spacing.xl),
            feedDescription.trailingAnchor
                .constraint(
                    equalTo: containerView.trailingAnchor),
            feedDescription.leadingAnchor
                .constraint(
                    equalTo: containerView.leadingAnchor),

            imageView.topAnchor
                .constraint(
                    equalTo: feedDescription.bottomAnchor),
            imageView.trailingAnchor
                .constraint(
                    equalTo: containerView.trailingAnchor),
            imageView.bottomAnchor
                .constraint(equalTo: createdAt.topAnchor, constant: -Spacing.xl),
            imageView.leadingAnchor
                .constraint(
                    equalTo: containerView.leadingAnchor),
        ]
)
    }
}
