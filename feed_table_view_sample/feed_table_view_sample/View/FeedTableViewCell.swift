//
//  UITextFeedCell.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 09/04/25.
//

import UIKit

class FeedTableViewCell: UITableViewCell, FeedConfigurable {

    let containerView = UIView()
    let author = UILabel()
    let title = UILabel()
    let tagLabel = TagLabel()
    let headerHorizontalStack = HeaderStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.black.cgColor
        //TODO: Add bottom border
    }

    private func setupCell() {
        headerHorizontalStack.setUpViews(leadView: author, trailView: tagLabel)
        setupLabels()
        headerHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(headerHorizontalStack)
        containerView.addSubview(title)

        contentView.addSubview(containerView)

        NSLayoutConstraint.activate(
[
            containerView.topAnchor
                .constraint(
                    equalTo: contentView.topAnchor,
                    constant: Spacing.s
                ),
            containerView.trailingAnchor
                .constraint(
                    equalTo: contentView.trailingAnchor,
                    constant: -Spacing
                        .l),
            containerView.bottomAnchor
                .constraint(
                    equalTo: contentView.bottomAnchor,
                    constant: -Spacing
                        .m),
            containerView.leadingAnchor
                .constraint(
                    equalTo: contentView.leadingAnchor,
                    constant: Spacing
                        .l),

            // MARK: - Header Horizontal Stack
            headerHorizontalStack.topAnchor
                .constraint(
                    equalTo: containerView.topAnchor,
                    constant: Spacing
                        .s),
            headerHorizontalStack.trailingAnchor
                .constraint(
                    equalTo: containerView.trailingAnchor,
                    constant: -Spacing
                        .l),
            headerHorizontalStack.leadingAnchor
                .constraint(
                    equalTo: containerView.leadingAnchor,
                    constant: Spacing
                        .l),

            // MARK: - Title Label
            title.topAnchor
                .constraint(
                    equalTo: headerHorizontalStack.bottomAnchor,
                    constant: Spacing
                        .s),
            title.trailingAnchor
                .constraint(
                    equalTo: containerView.trailingAnchor,
                    constant: -Spacing
                        .l),
            title.leadingAnchor
                .constraint(
                    equalTo: containerView.leadingAnchor,
                    constant: Spacing
                        .l),
        ]
)
    }

    private func setupLabels() {
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.translatesAutoresizingMaskIntoConstraints = false
        title.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

    func configure(with feed: FeedModel) {
        author.text = feed.author
        title.text = feed.title
        tagLabel.label.text = feed.type.rawValue
    }
}
