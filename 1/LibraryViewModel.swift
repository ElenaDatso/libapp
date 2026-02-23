//
//  LibraryViewModel.swift
//  1
//
//  Created by Elena Datso on 2026-02-20.
//

import Foundation

protocol LibraryViewModelDelegate: AnyObject {
    func didFinish()
    func didFail(error: Error)
}

protocol BooksServiceProtocol: AnyObject {
    func search(query: String) async throws -> [BookModel]
}

final class LibraryViewModel {

    private let booksService: BooksServiceProtocol
    private(set) var books: [BookModel] = []

    weak var delegate: LibraryViewModelDelegate?

    init(service: BooksServiceProtocol) {
        self.booksService = service
    }

    @MainActor
    func search(query: String) {
        Task {
            do {
                let result = try await booksService.search(query: query)
                self.books = result
                delegate?.didFinish()
            } catch {
                delegate?.didFail(error: error)
            }
        }

    }
}
