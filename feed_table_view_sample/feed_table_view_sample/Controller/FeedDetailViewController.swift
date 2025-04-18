//
//  FeedDetailViewController.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 17/04/25.
//

import UIKit

class FeedDetailViewController: UIViewController, FeedConfigurable {

    let containerView = UIView()
    var feed = FeedModel()
    let author = UILabel()
    let tagLabel = TagLabel()
    let headerStack = HeaderStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Configure header Stack
        headerStack.setUpViews(leadView: author, trailView: tagLabel)
        headerStack.translatesAutoresizingMaskIntoConstraints = false

        //Configure a super view that groups all content
        containerView.addSubview(headerStack)
        containerView.layer.backgroundColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false

        //Add the container view and pass on a background color
        view.addSubview(containerView)
        view.layer.backgroundColor = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            //Paddings
            containerView.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            headerStack.topAnchor
                .constraint(equalTo: containerView.topAnchor, constant: 20),
            headerStack.leadingAnchor
                .constraint(equalTo: containerView.leadingAnchor, constant: 16),
            headerStack.trailingAnchor
                .constraint(equalTo: containerView.trailingAnchor, constant: -16),
        ])
    }

    func configure(with feed: FeedModel) {
        self.feed = feed
        author.text = feed.author
        tagLabel.label.text = feed.type.rawValue
    }
}
