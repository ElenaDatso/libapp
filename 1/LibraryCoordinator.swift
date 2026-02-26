//
//  LibraryCoordinator.swift
//  1
//
//  Created by Elena Datso on 2026-02-25.
//
import UIKit

final class LibraryCoordinator {

    private let navigationController: UINavigationController
    
    private let service: BooksSearchServiceProtocol = CommandLine.arguments.contains("-ui-testing")
    ? MockBooksService()
    : BooksService()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vm = LibraryViewModel(service: service)
        let vc = LibraryViewController(viewModel: vm)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func showDetails(for book: BookModel) {
        let detailsVC = DetailsViewController(
            book: book,
            store: CoreDataBooksStore(
                context: PersistenceController.shared.container.viewContext
            )
        )
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
