//
//  FeedEditViewController.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 22/04/25.
//

import UIKit

class FeedEditViewController: FeedScrollViewController, FeedConfigurable {
    let authorTextField = UITextField()
    let titleTextField = UITextField()
    var messageDescription: UITextView? {
        didSet { setUpViews() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }

    func configure(with feed: FeedModel) {
        authorTextField.text = feed.author
        titleTextField.text = feed.title
    }
}

//MARK: - Views and Autolayout configuration

extension FeedEditViewController {
    private func setUpViews() {
        
        authorTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false

        authorTextField.delegate = self
        titleTextField.delegate = self
        authorTextField.keyboardType = .default
        authorTextField.keyboardAppearance = .light

        containerView.addSubview(authorTextField)
        containerView.addSubview(titleTextField)

        NSLayoutConstraint.activate(
[
            authorTextField.topAnchor
                .constraint(equalTo: containerView.topAnchor),
            authorTextField.trailingAnchor
                .constraint(equalTo: containerView.trailingAnchor),
            authorTextField.leadingAnchor
                .constraint(equalTo: containerView.leadingAnchor),

            titleTextField.topAnchor
                .constraint(
                    equalTo: authorTextField.lastBaselineAnchor,
                    constant: Spacing.xl),
            titleTextField.trailingAnchor
                .constraint(equalTo: containerView.trailingAnchor),
            titleTextField.leadingAnchor
                .constraint(equalTo: containerView.leadingAnchor),

        ]
)
    }

    private func setTextView() {
        if let messageDescription = self.messageDescription {
            print("Setting Message Description", messageDescription.text ?? "Nope")
            messageDescription.translatesAutoresizingMaskIntoConstraints = false
            messageDescription.isScrollEnabled = true
            messageDescription.textContainerInset = UIEdgeInsets(
                top: 4,
                left: 0,
                bottom: 4,
                right: 0
            )
            messageDescription.delegate = self
            messageDescription.textContainer.lineFragmentPadding = 0
            messageDescription.layer.borderColor = UIColor.lightGray.cgColor
            messageDescription.layer.borderWidth = 1.0
            messageDescription.clipsToBounds = true
            messageDescription.textAlignment = .left
            containerView.addSubview(messageDescription)
            NSLayoutConstraint.activate([
                messageDescription.topAnchor
                    .constraint(
                        equalTo: titleTextField.lastBaselineAnchor,
                        constant: Spacing.xl),
                messageDescription.trailingAnchor
                    .constraint(equalTo: containerView.trailingAnchor),
                messageDescription.leadingAnchor
                    .constraint(equalTo: containerView.leadingAnchor),
                messageDescription.heightAnchor.constraint(equalToConstant: 120)
            ])
        }
    }
}

extension FeedEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        // User changed the text selection.
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Return false to not change text.
        return true
    }
}

extension FeedEditViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}
