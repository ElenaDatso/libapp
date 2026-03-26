//
//  LibraryViewModel.swift
//  1
//
//  Created by Elena Datso on 2026-02-20.
//

import Foundation

enum ViewState {
    case idle, loading, results([BookModel]), empty, error(String)
}

protocol LibraryViewModelDelegate: AnyObject {
    func didFinishReloadData()
    func didFail(error: Error)
}

protocol BooksSearchServiceProtocol: AnyObject {
    func search(query: String) async throws -> [BookModel]
}

final class LibraryViewModel {

    private let booksService: BooksSearchServiceProtocol
    private(set) var books: [BookModel] = []
    private(set) var state: ViewState = .idle {
        didSet {
            onStateChange?(state)
        }
    }
    private var currentTask: Task<Void, Never>?
    
    var onStateChange: ((ViewState) -> Void)?

    weak var delegate: LibraryViewModelDelegate?
    var viewState: ((ViewState) -> Void)?

    init(service: BooksSearchServiceProtocol) {
        self.booksService = service
    }

    @MainActor
    func search(query: String) {
        guard !query.isEmpty else {
            state = .error("The search field is empty")
            return
        }
        currentTask?.cancel()
        state = .loading
        
        currentTask = Task {
            print("start task. state: \(state)")
            books = []
            delegate?.didFinishReloadData()
            
            do {
                let result = try await booksService.search(query: query)
                self.books = result
                if books.isEmpty {
                    state = .empty
                } else {
                    state = .results(books)
                }
                delegate?.didFinishReloadData()
            } catch {
                delegate?.didFail(error: error)
                state = .error("Error occured: \(error)")
            }
        }
    }
}
