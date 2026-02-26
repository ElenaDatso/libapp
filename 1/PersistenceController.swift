//
//  PersistenceController.swift
//  1
//
//  Created by Elena Datso on 2026-02-26.
//

import CoreData

final class PersistenceController {

    static let shared = PersistenceController()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "PocketLibrary")

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
