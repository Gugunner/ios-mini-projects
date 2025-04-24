//
//  FeedTableViewController.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 09/04/25.
//

import UIKit

class FeedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let loader = AppContextManager.app.shared.services.feedLoader
    let tableView = UITableView()
    let tester = FeedTester()
    var feeds: [FeedModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }

    private func loadData() {
        Task {
            do {
                try await loader.loadData()
                try loader.loadAllFeeds()
                feeds = loader.feeds ?? []
                tableView.reloadData()
            } catch {
                print("There was an error loading feeds: \(error)")
            }
        }
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

        if let feedCell = cell as? FeedTableViewCell {
            feedCell.configure(with: feed)
        }
        cell.accessibilityIdentifier = "\(cellIdentifier)_\(indexPath.row)"
        if let textCell = cell as? TextFeedTableViewCell { return textCell }

        if let postCell = cell as? PostFeedTableViewCell { return postCell }

        //Default Cell
        return cell
    }

    func cellIdentifier(for type: FeedType) -> String {
        switch (type) {
        case .post:
            return "PostFeedCell"
        case .text:
            return "TextFeedCell"
        default:
            return "FeedCell"
        }
    }

    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tester.shout(feed: feeds[indexPath.row]))
        tableView.deselectRow(at: indexPath, animated: false)
        guard indexPath.row < feeds.count else { return }
        let feed = feeds[indexPath.row]
        let feedDetailViewController = getFeedDetailViewController(
            type: feed.type
        )
        feedDetailViewController.configure(with: feed)
        navigationController?
            .pushViewController(
                feedDetailViewController,
                animated: true
            )
    }

    func getFeedDetailViewController(type: FeedType) -> FeedDetailViewController {
        switch type {
            case .text:
                return TextFeedDetailViewController()
            case .post:
                return PostFeedDetailViewController()
            default:
                return FeedDetailViewController()
        }
    }
}


