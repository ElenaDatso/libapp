//
//  CoreDataBookStore.swift
//  1
//
//  Created by Elena Datso on 2026-02-26.
//

import CoreData

protocol BooksStore {
    func save(_ book: BookModel) async throws
    func remove(_ book: BookModel) async throws
    func isSaved(_ book: BookModel) async -> Bool
}

final class CoreDataBooksStore: BooksStore {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func save(_ book: BookModel) async throws {
        try await context.perform {
            let entity = SavedBook(context: self.context)
            entity.id = book.id
            entity.title = book.title
            entity.author = book.author
            entity.dateSaved = Date()
            try self.context.save()
        }
    }

    func remove(_ book: BookModel) async throws {
        try await context.perform {
            let request: NSFetchRequest<SavedBook> = SavedBook.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", book.id)

            let results = try self.context.fetch(request)
            results.forEach { self.context.delete($0) }

            try self.context.save()
        }
    }

    func isSaved(_ book: BookModel) async -> Bool {
        await context.perform {
            let request: NSFetchRequest<SavedBook> = SavedBook.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", book.id)
            return (try? self.context.count(for: request)) ?? 0 > 0
        }
    }
}
