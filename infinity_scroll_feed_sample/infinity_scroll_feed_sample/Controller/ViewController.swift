//
//  ViewController.swift
//  infinity_scroll_feed_sample
//
//  Created by Raul_Alonzo on 12/05/25.
//

import UIKit

class ViewController: UIViewController {

    let headerStack = UIStackView()
    let titleLabel = UILabel()
    let table = UITableView()
    let presenter = FeedPresenter(repository: FeedRepository())

    var payload: FeedPayload?
    private var messages: [(String,String)] = []
    private var messagesCount = 0
    var loading = false


    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader()
        setTableView()
        setConstraints()
        presenter.view = self
        loading = true
        presenter.loadData()
    }

    private func setHeader() {
        titleLabel.text = "Infinity Scroll Feed Sample"
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        headerStack.addArrangedSubview(titleLabel)
        headerStack.spacing = 8
        headerStack.axis = .horizontal
        headerStack.distribution = .fill
        headerStack.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setTableView() {
        table.delegate = self
        table.dataSource = self
        table.prefetchDataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        table.rowHeight = 100
        table.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setConstraints() {
        view.addSubview(headerStack)
        view.addSubview(table)
        view.backgroundColor = .white

        NSLayoutConstraint.activate(
[
            //UIStackView
            headerStack.topAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: 20
                ),
            headerStack.trailingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -16
                ),
            headerStack.leadingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: 16
                ),

            //UITableView
            table.topAnchor
                .constraint(equalTo: headerStack.bottomAnchor, constant: 20),
            table.trailingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -16
                ),
            table.leadingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: 16
                ),
            table.bottomAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                    constant: -20
                )
        ]
)


    }

}

extension ViewController: UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesCount + (loading ? 1 : 0)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Loading Cell
        if loading && indexPath.row == messagesCount {
            return loadingCell
        }

        guard indexPath.row < messagesCount else  {
            print("Exit row:",indexPath.row, "messagesCount:",messagesCount)
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath
        )
        let message = messages[indexPath.row]
        var contentConfiguration = UIListContentConfiguration.valueCell()
        contentConfiguration.text = message.0
        contentConfiguration.secondaryText = message.1
        contentConfiguration.textToSecondaryTextHorizontalPadding = 8
        cell.contentConfiguration = contentConfiguration
        cell.selectionStyle = .none
        return cell
    }

    func tableView(
        _ tableView: UITableView,           
        prefetchRowsAt indexPaths: [IndexPath]
    ) {
        //Ensure not calling it again if data is loading or there are no more results
        guard !loading && payload?.page ?? 1 != payload?.totalPages ?? 1 else { return }

        //Consider a threshold of -5 at least to prevent issues when scrolling
        if indexPaths
            .contains(where: { $0.row >= messagesCount - 5 }) {
            print("Prefetching")
            loading = true
            table
                .insertRows(
                    at: [IndexPath(row: messagesCount, section: 0)],
                    with: .fade
                )
            presenter.loadData()
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        //Prevents allowing to select a row
        tableView.deselectRow(at: indexPath, animated: false)
        return nil
    }
}

extension ViewController: ViewDataProtocol {

    private var loadingCell: UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "LoadingCell")
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(spinner)
        NSLayoutConstraint.activate([
                spinner.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
            ])
        return cell
    }

    func loadData(_ data: PayloadProtocol) {
        guard let payload = data as? FeedPayload else {
            return
        }

        self.payload = payload
        let oldCount = messagesCount
        let newMessages = payload.messages
        let newBound = oldCount + newMessages.count

        messages.append(contentsOf: payload.messages)
        messagesCount = newBound

        print("oldCount:",oldCount)
        print("newBound:",newBound)
        
        let reloadIndex = IndexPath(row: oldCount, section: 0)
        let startIndex = oldCount
        let newIndexPaths = (startIndex..<newBound).map {
            IndexPath(row: $0, section: 0)
        }

        table.beginUpdates()
        loading = false
        table.deleteRows(at: [reloadIndex], with: .fade)
        if !newIndexPaths.isEmpty {
            table.insertRows(at: newIndexPaths, with: .none)
        }
        print("Adding new feeds")

        table.endUpdates()
    }
}
