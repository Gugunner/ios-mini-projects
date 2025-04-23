//
//  FeedDetailViewController.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 17/04/25.
//

import UIKit

class FeedDetailViewController: FeedScrollViewController, FeedConfigurable {

    var feed = FeedModel()
    let editButton = UIButton(type: .system)
    let author = UILabel()
    let tagLabel = TagLabel()
    let headerStack = HeaderStackView()
    let feedTitle = UILabel()
    let createdAt = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpActions()
    }

    func configure(with feed: FeedModel) {
        self.feed = feed
        author.text = feed.author
        tagLabel.label.text = feed.type.rawValue
        feedTitle.text = feed.title
        createdAt.text = "Posted on: \(getFormattedText(from: feed.createdAt))"
    }

    private func getFormattedText(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }
}

extension FeedDetailViewController {
    private func setUpViews() {
        //Configure header Stack
        headerStack.setUpViews(leadView: author, trailView: tagLabel)
        headerStack.translatesAutoresizingMaskIntoConstraints = false

        feedTitle.translatesAutoresizingMaskIntoConstraints = false
        feedTitle.numberOfLines = 2
        feedTitle.lineBreakMode = .byWordWrapping
        feedTitle.textColor = .label

        createdAt.translatesAutoresizingMaskIntoConstraints = false
        createdAt.numberOfLines = 1
        createdAt.font = UIFont.systemFont(ofSize: 12)
        createdAt.textAlignment = .right
        createdAt.textColor = .label

        editButton.translatesAutoresizingMaskIntoConstraints = false

        //Configure a super view that groups all content
        containerView.addSubview(headerStack)
        containerView.addSubview(feedTitle)
        containerView.addSubview(createdAt)
        containerView.addSubview(editButton)
        NSLayoutConstraint.activate(
[
            headerStack.topAnchor
                .constraint(
                    equalTo: containerView.topAnchor),
            headerStack.trailingAnchor
                .constraint(
                    equalTo: containerView.trailingAnchor),
            headerStack.leadingAnchor
                .constraint(
                    equalTo: containerView.leadingAnchor),

            feedTitle.topAnchor
                .constraint(
                    equalTo: headerStack.bottomAnchor),
            feedTitle.trailingAnchor
                .constraint(
                    equalTo: containerView.trailingAnchor),
            feedTitle.leadingAnchor
                .constraint(
                    equalTo: containerView.leadingAnchor),

            createdAt.bottomAnchor
                .constraint(
                    equalTo: containerView.bottomAnchor),
            createdAt.trailingAnchor
                .constraint(
                    equalTo: containerView.trailingAnchor),

            editButton.bottomAnchor
                .constraint(
                    equalTo: containerView.bottomAnchor),
            editButton.leadingAnchor
                .constraint(equalTo: containerView.leadingAnchor)
        ]
)
    }
}

//MARK: - Actions
extension FeedDetailViewController {

    private func setUpActions() {
        editButton
            .setTitle(NSLocalizedString("Edit", comment: ""), for: .normal)
        editButton
            .addTarget(
                self,
                action: #selector(onEditFeed(_:)),
                for: .touchUpInside
            )
    }

    @objc func onEditFeed(_ sender: UIButton) {
        guard let navigationController = self.navigationController else { return }
        let editVC = FeedEditViewController()
        editVC.configure(with: feed)
        navigationController.pushViewController(editVC, animated: true)
    }
}
