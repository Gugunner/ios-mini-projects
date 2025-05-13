//
//  ViewController.swift
//  local_persistence_form_sample
//
//  Created by Raul_Alonzo on 13/05/25.
//

import UIKit

class ViewController: UIViewController {

    let titleLabel = UILabel()
    let userNameField = UITextField()
    let emailField = UITextField()
    let submitButton = UIButton()
    let submitSpinner = UIActivityIndicatorView(style: .medium)

    var submitting = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        setUserNameField()
        setEmailField()
        setSubmitButton()
        setConstraints()
    }

    private func setTitle() {
        titleLabel.text = "Local Persistence Form Sample"
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setUserNameField() {
        userNameField.delegate = self
        userNameField.placeholder = "Username"
        let image = UIImage(systemName: "person")
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
        userNameField.leftView = containerView
        userNameField.leftViewMode = .always
        userNameField.borderStyle = .line
        userNameField.textAlignment = .left
        userNameField.becomeFirstResponder()
        userNameField.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setEmailField() {
        emailField.delegate = self
        emailField.placeholder = "email"
        emailField.keyboardType = .emailAddress
        let image = UIImage(systemName: "paperplane")
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
        emailField.leftView = containerView
        emailField.leftViewMode = .always
        emailField.borderStyle = .line
        emailField.textAlignment = .left
        emailField.becomeFirstResponder()
        emailField.translatesAutoresizingMaskIntoConstraints = false
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

            //UIButton
            submitButton.topAnchor
                .constraint(equalTo: emailField.bottomAnchor, constant: 28),
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

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("Prev:", textField.text ?? "", "Next:",string)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //TODO: Add logic to check if username and email already stored
        return true
    }
}

extension ViewController {

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

    @MainActor
    @objc func storeUser() {
        //TODO: Add logic to send user to user repository
        print("Storing user")
        Task {
            submitting = true
            configSubmitButton()
            try await Task.sleep(nanoseconds: 2_000_000_000)
            submitting = false
            configSubmitButton()
        }
    }
}
