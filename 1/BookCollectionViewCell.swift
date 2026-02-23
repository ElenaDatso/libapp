//
//  LibraryCollectionViewCell.swift
//  1
//
//  Created by Elena Datso on 2026-02-20.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    private var vw: BookView?
    
    var item: BookModel? {
        didSet {
            guard let title = item?.title,
                  let author = item?.author else {
                return
            }
            vw?.set(title: title, author: author)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BookCollectionViewCell {
    func setup() {
        guard vw == nil else {return}
        
        vw = BookView {
            print("click")
        }
        self.contentView.addSubview(vw!)
        NSLayoutConstraint.activate([
            vw!.topAnchor.constraint(equalTo: contentView.topAnchor),
            vw!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            vw!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            vw!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}
