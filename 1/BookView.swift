//
//  PersonView.swift
//  1
//
//  Created by Elena Datso on 2026-02-19.
//

import UIKit

class BookView: UIView {

    private lazy var detailsBtn: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Details"
        config.baseBackgroundColor = .red
        config.baseForegroundColor = .white
        config.buttonSize = .large
        config.cornerStyle = .medium
        
        let btn = UIButton(configuration: config)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTapSubscribe), for: .touchUpInside)
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
    
    private lazy var personStackView: UIStackView = {
        let vw = UIStackView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.axis = .vertical
        vw.spacing = 8
        return vw
    }()
    
    private var action: () -> ()
    
    init(action: @escaping () -> ()) {
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
    
    @objc func didTapSubscribe(sender: UIButton) {
        action()
    }
}

private extension BookView {
    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .gray.withAlphaComponent(0.1)
        self.layer.cornerRadius = 8
        
        self.addSubview(personStackView)
        
        personStackView.addArrangedSubview(titleLbl)
        personStackView.addArrangedSubview(authorLbl)
        personStackView.addArrangedSubview(detailsBtn)
        
        NSLayoutConstraint.activate([
            personStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            personStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            personStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            personStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
}
