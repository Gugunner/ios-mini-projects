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
    var messageDescription: UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createUserActivity()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        clearUserActivity()

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
        setTextView()
    }

    private func setTextView() {
        if let messageDescription = self.messageDescription {
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


//MARK: - Store and Restore State
extension FeedEditViewController {
    private func createUserActivity() {
        let activity = NSUserActivity(activityType: "com.feed.editting")
        activity.title = self.title
        self.userActivity = activity
        view.window?.windowScene?.userActivity = activity
    }

    override func updateUserActivityState(_ activity: NSUserActivity) {
        super.updateUserActivityState(activity)
        let entries:[AnyHashable:Any] = [
            "author":authorTextField.text ?? "",
            "title":titleTextField.text ?? "",
            "messageDescription": messageDescription?.text ?? ""
        ]
        activity.addUserInfoEntries(from: entries)
    }

    private func clearUserActivity() {
        if let activity = view.window?.windowScene?.userActivity {
            activity.userInfo?.removeValue(forKey: "author")
            activity.userInfo?.removeValue(forKey: "title")
            activity.userInfo?.removeValue(forKey: "messageDescription")
            self.userActivity?.resignCurrent()
        }
    }

    //MARK: - Restores edit fields
    func restore(from activity: NSUserActivity) {
        authorTextField.text = "Author Test"
        titleTextField.text = "Test"
        if let messageDescription = activity.userInfo?["messageDescription"] as? String {
            self.messageDescription = UITextView()
            self.messageDescription?.text = messageDescription
        }
    }
}
