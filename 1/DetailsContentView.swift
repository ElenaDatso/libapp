//
//  DetailsContentView.swift
//  1
//
//  Created by Elena Datso on 2026-02-26.
//

import UIKit

final class DetailsContentView: UIView {

    var onSaveTapped: (() -> Void)?

    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let saveButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String, author: String, buttonTitle: String) {
        titleLabel.text = title
        authorLabel.text = author
        saveButton.setTitle(buttonTitle, for: .normal)
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground

        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.numberOfLines = 0

        authorLabel.font = .systemFont(ofSize: 16)
        authorLabel.textColor = .secondaryLabel

        saveButton.backgroundColor = .systemOrange
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            authorLabel,
            saveButton
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
    }

    @objc private func saveTapped() {
        onSaveTapped?()
    }
}
