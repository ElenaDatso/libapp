//
//  BooksService.swift
//  1
//
//  Created by Elena Datso on 2026-02-22.
//

import Foundation

enum QueryError: Error {
    case emptyQuery
    case invalidURL
}

final class BooksService: BooksSearchServiceProtocol {

    func search(query: String) async throws -> [BookModel] {
        
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            throw QueryError.emptyQuery
        }

        var components = URLComponents(string: "https://openlibrary.org/search.json")
        components?.queryItems = [
            URLQueryItem(name: "q", value: trimmed)
        ]
        
        guard let url = components?.url else {
            throw QueryError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(LibraryResponseModel.self, from: data)

        return response.docs.map { BookModel(dto: $0) }
    }
}
