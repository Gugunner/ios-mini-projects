//
//  ViewController.swift
//  stream_messages_sample
//
//  Created by Raul_Alonzo on 12/05/25.
//

import UIKit
import Foundation
import Combine

class ViewController: UIViewController {

    let headerStack = UIStackView()
    let titleLabel = UILabel()
    let table = UITableView()
    let viewModel = ChatViewModel()
    var subscriber: AnyCancellable?
    let sendButton = UIButton(type: .custom)
    var count = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setHeader()
        setTableView()
        setButton()
        setConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View appeared")
        subscriber = viewModel.$messages
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] message in
                guard let self, self.viewModel.messages.count > 0 else  {return }

                let newIndexPath = IndexPath(row: self.viewModel.messages.count - 1, section: 0)
                print("Adding message to table")
                self.table.insertRows(at: [newIndexPath], with: .automatic)
        })
        viewModel.startStream()
    }

    override func viewDidDisappear(_ animated: Bool) {
        print("View Disappeared")
        subscriber?.cancel()
        viewModel.stopStream()
        super.viewDidDisappear(animated)
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

    private func setButton()  {
        sendButton.setTitle("Send", for: .normal)
        sendButton
            .addTarget(
                self,
                action: #selector(sendUserMessage),
                for: .touchUpInside
            )
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.backgroundColor = .white
        sendButton.setTitleColor(.black, for: .normal)
        sendButton.layer.cornerRadius = 8
        sendButton.layer.borderColor = UIColor.black.cgColor
        sendButton.layer.borderWidth = 1
    }

    private func setConstraints() {
        view.addSubview(headerStack)
        view.addSubview(table)
        view.addSubview(sendButton)
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
//            table.bottomAnchor
//                .constraint(
//                    equalTo: sendButton.topAnchor,
//                    constant: -20
//                ),

            //UIButton
            sendButton.topAnchor
                .constraint(equalTo: table.bottomAnchor, constant: 20),
            sendButton.leadingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: 16
                ),
            sendButton.widthAnchor.constraint(equalToConstant: 80),
//            sendButton.trailingAnchor
//                .constraint(
//                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
//                    constant: -16
//                ),
            sendButton.bottomAnchor
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
        print("Rows count:",viewModel.messages.count)
        return viewModel.messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath
        )
        guard indexPath.row < viewModel.messages.count else {
            return UITableViewCell()
        }

        var contentConfiguration = UIListContentConfiguration.cell()
        let message = viewModel
            .messages[indexPath.row]
        contentConfiguration.text = message.primaryText
        contentConfiguration.secondaryText = message.secondaryText
        cell.selectionStyle = .none
        cell.contentConfiguration = contentConfiguration
        return cell
    }
}

extension ViewController {
    @objc func sendUserMessage() {
        let message = Message(id: count, primaryText: "User -> \(count)", secondaryText: "Local Message")
        print("Send user message")
        viewModel.send(message: message)
        count += 1
    }
}
