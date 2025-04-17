//
//  FeedTableViewController.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 09/04/25.
//

import UIKit

class FeedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let loader = FeedLoader()
    let tableView = UITableView()
    let tester = FeedTester()
    var feeds: [FeedModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }

    private func loadData() {
        do {
            try feeds = loader.loadAllFeeds(data: dataSample)
        } catch {
            print("There was an error loading feeds: \(error)")
        }
        tableView.reloadData()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView
            .register(
                FeedTableViewCell.self,
                forCellReuseIdentifier: "FeedCell"
            )
        tableView.register(TextFeedTableViewCell.self, forCellReuseIdentifier: "TextFeedCell")
        tableView.register(PostFeedTableViewCell.self, forCellReuseIdentifier: "PostFeedCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - UITableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < feeds.count else { return UITableViewCell() }
        let feed = feeds[indexPath.row]
        let cellIdentifier = cellIdentifier(for: feed.type)

        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath
        )

        if let textCell = cell as? TextFeedTableViewCell {
            textCell.configure(with: feed)
            return textCell
        }

        if let postCell = cell as? PostFeedTableViewCell {
            postCell.configure(with: feed)
            return postCell
        }

        if let feedCell = cell as? FeedTableViewCell {
            feedCell.configure(with: feed)
            return feedCell
        }

        return cell
    }

    func cellIdentifier(for type: FeedType) -> String {
        switch (type) {
        case FeedType.post:
            return "PostFeedCell"
        case FeedType.text:
            return "TextFeedCell"
        default:
            return "FeedCell"
        }
    }

    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tester.shout(feed: feeds[indexPath.row]))
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


