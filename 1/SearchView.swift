//
//  SearchView.swift
//  1
//
//  Created by Elena Datso on 2026-02-21.
//

import UIKit

final class SearchView: UIView {
    
    var onSearchTapped: ((String) -> Void)?
    var onTextChanged: ((String) -> Void)?
        
    private let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search books..."
        tf.borderStyle = .none
        tf.layer.cornerRadius = 10
        tf.backgroundColor = UIColor.systemGray6
        tf.clearButtonMode = .whileEditing
        tf.returnKeyType = .search
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 24))
        imageView.center = container.center
        container.addSubview(imageView)
        
        tf.leftView = container
        tf.leftViewMode = .always
        
        return tf
    }()
    
    private let searchButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Search", for: .normal)
        btn.backgroundColor = .systemOrange
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textField, searchButton])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
        
    init(onTap: @escaping (String) -> Void,
         onText: @escaping (String) -> Void) {
        self.onSearchTapped = onTap
        self.onTextChanged = onText
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SearchView {
    
    func setup() {
        backgroundColor = .white
        addSubview(stack)
        textField.delegate = self
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            searchButton.widthAnchor.constraint(equalToConstant: 100),
            textField.heightAnchor.constraint(equalToConstant: 44),
            searchButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        
        textField.delegate = self
        
        textField.accessibilityIdentifier = "searchTextField"
        searchButton.accessibilityIdentifier = "searchButton"
    }
    
    @objc func textChanged() {
        onTextChanged?(textField.text ?? "")
    }
    
    @objc func searchTapped() {
        endEditing(true)
        onSearchTapped?(textField.text ?? "")
    }
}

extension SearchView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchTapped()
        return true
    }
}
