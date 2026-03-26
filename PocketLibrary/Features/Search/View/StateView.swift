//
//  StateView.swift
//  PocketLibrary
//
//  Created by Elena Datso on 2026-03-26.
//

import Foundation
import UIKit

final class StateView: UIView {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    init(image: UIImage?, title: String, subtitle: String) {
        super.init(frame: .zero)
        setup(image: image, title: title, subtitle: subtitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup (image: UIImage?, title: String, subtitle: String) {
        imageView.image = image
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.text = title
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.textAlignment = .center
        
        subtitleLabel.text = subtitle
        subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -80),

            stack.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -16),

            imageView.heightAnchor.constraint(equalToConstant: 30),
            imageView.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
}

extension StateView {
    func config (image: UIImage?, title: String, subtitle: String) {
        imageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
