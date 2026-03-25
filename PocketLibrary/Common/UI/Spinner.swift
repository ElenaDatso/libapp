//
//  Spinner.swift
//  PocketLibrary
//
//  Created by Elena Datso on 2026-03-25.
//

import Foundation
import UIKit

final class Spinner: UIActivityIndicatorView  {
    
    override init(style: UIActivityIndicatorView.Style) {
        
        super.init(style: style)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension Spinner {
    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


