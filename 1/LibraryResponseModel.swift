//
//  LibraryResponseModel.swift
//  1
//
//  Created by Elena Datso on 2026-02-20.
//

import Foundation

struct LibraryResponseModel: Decodable {
    let docs: [BookDTO]
}

struct BookDTO: Decodable {
    let key: String
    let author_name: [String]?
    let title: String?
}

struct BookModel {
    let id: String
    let title: String
    let author: String
}

extension BookModel {
    init(dto: BookDTO) {
        self.id = dto.key
        self.title = dto.title ?? "Unknown Title"
        self.author = dto.author_name?.first ?? "Unknown Author"
    }
}
