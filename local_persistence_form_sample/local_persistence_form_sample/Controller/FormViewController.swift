//
//  FormViewController.swift
//  local_persistence_form_sample
//
//  Created by Raul_Alonzo on 13/05/25.
//

import UIKit
//TODO: Add AppState for users stored and coordinate with CoreData for validation and context save via AppDelegate
class FormViewController: UIViewController {

    let titleLabel = UILabel()
    let userNameField = UITextField()
    let emailField = UITextField()
    let alertLabel = UILabel()
    let submitButton = UIButton()
    let submitSpinner = UIActivityIndicatorView(style: .medium)

    var repository: UserRepository!
    var submitting = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        setUserNameField()
        setEmailField()
        setAlertLabel()
        setSubmitButton()
        setConstraints()
    }

    private func setTitle() {
        titleLabel.text = "Local Persistence Form Sample"
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setUserNameField() {
        userNameField.delegate = self
        userNameField.placeholder = "Username"
        userNameField.restorationIdentifier = "username"
        userNameField.textContentType = .username
        let containerView = setTextFieldIcon(with: "person")
        userNameField.leftView = containerView
        userNameField.leftViewMode = .always
        userNameField.borderStyle = .line
        userNameField.textAlignment = .left
        userNameField.textColor = .black
        userNameField.becomeFirstResponder()
        userNameField.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setEmailField() {
        emailField.delegate = self
        emailField.placeholder = "email"
        emailField.keyboardType = .emailAddress
        emailField.textContentType = .emailAddress
        emailField.restorationIdentifier = "email"
        let containerView = setTextFieldIcon(with: "paperplane")
        emailField.leftView = containerView
        emailField.leftViewMode = .always
        emailField.borderStyle = .line
        emailField.textAlignment = .left
        emailField.textColor = .black
        emailField.becomeFirstResponder()
        emailField.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setTextFieldIcon(with systemName: String) -> UIView {
        let image = UIImage(systemName: systemName)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
                imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
                imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
        return containerView
    }

    private func setAlertLabel() {
        alertLabel.textColor = .black
        alertLabel.textAlignment = .left
        alertLabel.numberOfLines = 1
        alertLabel.lineBreakMode = .byWordWrapping
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.isHidden = true
    }

    private func setSubmitButton() {
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitle("Submit", for: .disabled)
        submitButton.setTitle("", for: [.selected, .disabled])
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.setTitleColor(.gray, for: .disabled)
        submitButton.layer.cornerRadius = 8
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.role = .primary

        submitButton
            .addTarget(
                self,
                action: #selector(storeUser),
                for: .touchUpInside
            )
        submitButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setConstraints() {
        view.addSubview(titleLabel)
        view.addSubview(userNameField)
        view.addSubview(emailField)
        view.addSubview(alertLabel)
        view.addSubview(submitButton)
        view.backgroundColor = .white
        NSLayoutConstraint.activate(
[
            //UILabel
            titleLabel.topAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: 20
                ),
            titleLabel.trailingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -16
                ),
            titleLabel.leadingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: 16
                ),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            //UITextFields
            userNameField.topAnchor
                .constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            userNameField.trailingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -16
                ),
            userNameField.leadingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: 16
                ),
            userNameField.heightAnchor.constraint(equalToConstant: 40),
            emailField.topAnchor
                .constraint(equalTo: userNameField.bottomAnchor, constant: 8),
            emailField.trailingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -16
                ),
            emailField.leadingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: 16
                ),
            emailField.heightAnchor.constraint(equalToConstant: 40),

            //UILabel
            alertLabel.topAnchor
                .constraint(equalTo: emailField.bottomAnchor, constant: 20),
            alertLabel.trailingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -16
                ),
            alertLabel.leadingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: 16
                ),

            //UIButton
            submitButton.topAnchor
                .constraint(equalTo: alertLabel.bottomAnchor, constant: 20),
            submitButton.trailingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -16
                ),
            submitButton.leadingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: 16
                ),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
)
    }
}

extension FormViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("Prev:", textField.text ?? "", "Next:",string)
        if !alertLabel.isHidden {
            clearAlertLabel()
        }
        if textField.restorationIdentifier != "email" {
            return true
        }
        guard let currentText = textField.text as NSString? else { return true }
        let updatedText = currentText.replacingCharacters(
            in: range,
            with: string.lowercased()
        )
        textField.text = updatedText
        return false
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //TODO: Add logic to check if username and email already stored
        return true
    }
}

// MARK: - UI Submitting
extension FormViewController {
    private func resignResponders() {
        if userNameField.isFirstResponder {
            userNameField.resignFirstResponder()
        }

        if emailField.isFirstResponder {
            emailField.resignFirstResponder()
        }
    }

    private func configSpinner() {
        if (submitting) {
            submitButton.addSubview(submitSpinner)
            submitSpinner.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                submitSpinner.centerXAnchor.constraint(equalTo: submitButton.centerXAnchor),
                submitSpinner.centerYAnchor.constraint(equalTo: submitButton.centerYAnchor)
            ])
            submitSpinner.startAnimating()
        } else {
            submitSpinner.stopAnimating()
            submitSpinner.removeFromSuperview()
        }
    }

    private func configSubmitButton() {
        submitButton.isEnabled = !submitting
        submitButton.isSelected = submitting

        submitButton.backgroundColor = submitting ? .gray
            .withAlphaComponent(0.05) : .white
        submitButton.layer.borderColor = submitting ? UIColor.gray
            .withAlphaComponent(0.25).cgColor : UIColor.black.cgColor
        configSpinner()
    }
}

// MARK: - User CoreData Storage
extension FormViewController {

    //Must run in main since it calls UI changes
    @MainActor
    @objc func storeUser() {
        assert(repository != nil, "repository must be injected")
        //TODO Validate textFields
        guard let userName = userNameField.text, let email = emailField.text, userName.count > 4, email.count > 4 else {
            return
        }
        resignResponders()


        Task {
            submitting = true
            configSubmitButton()
            let user = UserModel(
                id: UUID(),
                userName: userName,
                email: email
            )
            //Simulate async call
            try await Task.sleep(nanoseconds: 2_000_000_000)
            print("Storing user")
            let result = await repository.storeUser(user: user)
            switch (result) {
                case .success(let val):
                if val {
                    clearFields()
                    processSuccess(user)
                }
                case .failure(let error):
                    processError(error)
                }
            alertLabel.isHidden = false
            submitting = false
            configSubmitButton()
        }
    }

    private func processSuccess(_ user: UserModel) {
        alertLabel.text = "User \(user.userName) was created!"
        alertLabel.textColor = .green
    }

    private func processError(_ error: CoreDataError) {
        var errorText: String
        switch (error) {
        case .alreadyExists:
            errorText = "The username or email are already in use."
        case .cannotStore:
            errorText = "We cannot store the user at this moment."
        default:
            errorText = "An unknown error occured."
        }
        alertLabel.text = errorText
        alertLabel.textColor = .red
        print("User Failed to store")
    }

    private func clearFields() {
        userNameField.text = nil
        emailField.text = nil
    }

    private func clearAlertLabel() {
        alertLabel.text = nil
        alertLabel.textColor = .black
        alertLabel.isHidden = true
    }
}
