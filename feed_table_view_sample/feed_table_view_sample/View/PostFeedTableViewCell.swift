//
//  PostFeedTableViewCell.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 16/04/25.
//

import UIKit

class PostFeedTableViewCell: FeedTableViewCell {

    let contentImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setImageFromName(named: String) {
        guard let image = UIImage(named: named) else { return }
        contentImageView.image = image
        contentImageView.clipsToBounds = true
        contentImageView.contentMode = .scaleAspectFit
        contentImageView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(contentImageView)
        let aspectRatio = image.size.height / image.size.width
        NSLayoutConstraint.activate([
            // MARK: - Padding
            contentImageView.topAnchor
                .constraint(equalTo: title.bottomAnchor, constant: 8),
            contentImageView.trailingAnchor
                .constraint(equalTo: title.trailingAnchor),
            contentImageView.leadingAnchor
                .constraint(equalTo: title.leadingAnchor),
            contentImageView.bottomAnchor
                .constraint(equalTo: containerView.bottomAnchor, constant: -16),

            // MARK: - Dimensions
            contentImageView.heightAnchor
                .constraint(
                    equalTo: contentImageView.widthAnchor,
                    multiplier: aspectRatio
                )
        ])
    }

    override func configure(with feed: FeedModel) {
        super.configure(with: feed)
        guard let postFeed = feed as? PostFeedModel else { return }
        setImageFromName(named: postFeed.imagePath)
    }
}
