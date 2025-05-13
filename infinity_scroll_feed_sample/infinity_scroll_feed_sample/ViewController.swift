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

    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader()
        setTableView()
        setConstraints()
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
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath
        )
        var contentConfiguration = UIListContentConfiguration.valueCell()
        contentConfiguration.text = "Primary -> \(indexPath.row)"
        contentConfiguration.secondaryText = "Secondary"
        contentConfiguration.textToSecondaryTextHorizontalPadding = 8
        cell.contentConfiguration = contentConfiguration
        cell.selectionStyle = .none
        return cell
    }

    func tableView(
        _ tableView: UITableView,           
        prefetchRowsAt indexPaths: [IndexPath]
    ) {
        //TODO: Add prefetch when reaching 5 items before last
    }


}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        //Prevents allowing to select a row
        tableView.deselectRow(at: indexPath, animated: false)
        return nil
    }
}

