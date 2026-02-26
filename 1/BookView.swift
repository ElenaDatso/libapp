//
//  PersonView.swift
//  1
//
//  Created by Elena Datso on 2026-02-19.
//

import UIKit

class BookView: UIView {
    
    private var labelText: String = ""

    private lazy var actionBtn: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = self.labelText
        config.baseBackgroundColor = .red
        config.baseForegroundColor = .white
        config.buttonSize = .large
        config.cornerStyle = .medium
        
        let btn = UIButton(configuration: config)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTapDetails), for: .touchUpInside)
        return btn
    }()
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 14, weight: .bold)
        return lbl
    }()
    
    private lazy var authorLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 12, weight: .regular)
        return lbl
    }()
    
    private lazy var bookStackView: UIStackView = {
        let vw = UIStackView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.axis = .vertical
        vw.spacing = 8
        return vw
    }()
    
    private var action: (() -> Void)?
    
    init(labelText: String, action: (() -> Void)? = nil) {
        self.labelText = labelText
        self.action = action
        super.init(frame: .zero)
        setup()
    }

    
    required init?(coder: NSCoder) {
        fatalError("Something went wrong")
    }
    
    func set (title: String, author: String) {
        titleLbl.text = title
        authorLbl.text = author
    }
    
    @objc func didTapDetails(sender: UIButton) {
        print("action")
        action?()
    }
}

private extension BookView {
    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .gray.withAlphaComponent(0.1)
        self.layer.cornerRadius = 8
        
        self.addSubview(bookStackView)
        
        bookStackView.addArrangedSubview(titleLbl)
        bookStackView.addArrangedSubview(authorLbl)
        bookStackView.addArrangedSubview(actionBtn)
        
        NSLayoutConstraint.activate([
            bookStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            bookStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            bookStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            bookStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
}
