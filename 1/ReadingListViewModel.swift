//
//  ReadingListViewModel.swift
//  1
//
//  Created by Elena Datso on 2026-02-27.
//

final class ReadingListViewModel {

    private let store: BooksStore
    private(set) var books: [BookModel] = []

    init(store: BooksStore) {
        self.store = store
    }

    @MainActor
    func load() async throws {
        books = try await store.fetchSavedBooks()
    }
}
