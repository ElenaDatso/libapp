//
//  MockBooksService.swift
//  1
//
//  Created by Elena Datso on 2026-02-22.
//

import Foundation

final class MockBooksService: BooksSearchServiceProtocol {
    
    var shouldReturnError = false
    
    func search(query: String) async throws -> [BookModel] {
        
        if shouldReturnError {
            throw MockError.testError
        }
        
        return [
                    BookModel(
                        id: "123456",
                        title: "The Swift Programming Language",
                        author: "Apple"
                    ),
                    BookModel(
                        id: "78910",
                        title: "Harry Potter",
                        author: "J.K. Rowling"
                    )
                ]
    }
}

enum MockError: Error {
    case testError
}
