//
//  DetailsViewModel.swift
//  1
//
//  Created by Elena Datso on 2026-02-26.
//

import Foundation

final class DetailsViewModel {

    enum SaveState {
        case notSaved
        case saved
    }

    enum ViewState {
        case idle
        case loading
        case error(String)
    }

    private let book: BookModel
    private let store: BooksStore

    private(set) var saveState: SaveState = .notSaved
    private(set) var viewState: ViewState = .idle

    init(book: BookModel, store: BooksStore) {
        self.book = book
        self.store = store
    }


    var titleText: String { book.title }
    var authorText: String { book.author }

    var buttonTitle: String {
        saveState == .saved ? "Remove from list" : "Save to list"
    }

    func load() async {
        let saved = await store.isSaved(book)
        saveState = saved ? .saved : .notSaved
    }

    func onSaveTapped() async {
        viewState = .loading

        do {
            switch saveState {
            case .notSaved:
                try await store.save(book)
                saveState = .saved
            case .saved:
                try await store.remove(book)
                saveState = .notSaved
            }

            viewState = .idle
        } catch {
            viewState = .error("Failed to save book")
        }
    }
}
