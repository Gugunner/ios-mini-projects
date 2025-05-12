//
//  ViewController.swift
//  stream_messages_sample
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
        // Do any additional setup after loading the view.
        setHeader()
        setTableView()
        setConstraints()
    }

    private func setTableView() {
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 100
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        table.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setHeader() {
        //Label config
        titleLabel.text = "Stream messages sample"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byWordWrapping
        
        //StackView config
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        headerStack.addArrangedSubview(titleLabel)
        headerStack.axis = .horizontal
        headerStack.distribution = .fill
        headerStack.alignment = .center
        headerStack.spacing = 8
    }

    private func setConstraints() {
        view.addSubview(headerStack)
        view.addSubview(table)
        view.backgroundColor = .white
        NSLayoutConstraint.activate(
[
            //StackView
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

            //TableView
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


extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        //Prevents allowing to select a row
        tableView.deselectRow(at: indexPath, animated: false)
        return nil
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath
        )

        var contentConfiguration = UIListContentConfiguration.cell()
        contentConfiguration.text = "Primary \(indexPath.row) ->"
        contentConfiguration.secondaryText = "Secondary"
        cell.selectionStyle = .none
        cell.contentConfiguration = contentConfiguration
        return cell
    }
}
