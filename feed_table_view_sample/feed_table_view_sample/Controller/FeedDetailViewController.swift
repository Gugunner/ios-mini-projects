//
//  FeedDetailViewController.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 17/04/25.
//

import UIKit

class FeedDetailViewController: UIViewController, FeedConfigurable {

    let containerView = UIView()
    let scrollView = UIScrollView()
    var feed = FeedModel()
    let author = UILabel()
    let tagLabel = TagLabel()
    let headerStack = HeaderStackView()
    let feedTitle = UILabel()
    let createdAt = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Configure header Stack
        headerStack.setUpViews(leadView: author, trailView: tagLabel)
        headerStack.translatesAutoresizingMaskIntoConstraints = false

        feedTitle.translatesAutoresizingMaskIntoConstraints = false
        feedTitle.numberOfLines = 2
        feedTitle.lineBreakMode = .byWordWrapping

        createdAt.translatesAutoresizingMaskIntoConstraints = false
        createdAt.numberOfLines = 1
        createdAt.font = UIFont.systemFont(ofSize: 12)
        createdAt.textAlignment = .right

        //Configure a super view that groups all content
        containerView.addSubview(headerStack)
        containerView.addSubview(feedTitle)
        containerView.addSubview(createdAt)
        containerView.layer.backgroundColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)

        //Add the container view and pass on a background color
        view.addSubview(scrollView)
        view.layer.backgroundColor = UIColor.white.cgColor
        
        NSLayoutConstraint.activate(
[
            //Paddings
            scrollView.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.trailingAnchor
                .constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor
                .constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor
                .constraint(equalTo: scrollView.leadingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            headerStack.topAnchor
                .constraint(
                    equalTo: containerView.topAnchor,
                    constant: Spacing
                        .xl),
            headerStack.trailingAnchor
                .constraint(
                    equalTo: containerView.trailingAnchor,
                    constant: -Spacing
                        .l),
            headerStack.leadingAnchor
                .constraint(
                    equalTo: containerView.leadingAnchor,
                    constant: Spacing
                        .l),

            feedTitle.topAnchor
                .constraint(
                    equalTo: headerStack.bottomAnchor,
                    constant: Spacing
                        .xl),
            feedTitle.trailingAnchor
                .constraint(
                    equalTo: containerView.trailingAnchor,
                    constant: -Spacing
                        .l),
            feedTitle.leadingAnchor
                .constraint(
                    equalTo: containerView.leadingAnchor,
                    constant: Spacing
                        .l),

            createdAt.bottomAnchor
                .constraint(
                    equalTo: containerView.bottomAnchor,
                    constant: -Spacing
                        .xl),
            createdAt.trailingAnchor
                .constraint(
                    equalTo: containerView.trailingAnchor,
                    constant: -Spacing
                        .l),
        ]
)
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
