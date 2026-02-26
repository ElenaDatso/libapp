//
//  DetailsViewController.swift
//  1
//
//  Created by Elena Datso on 2026-02-25.
//

import UIKit

final class DetailsViewController: UIViewController {

    private let viewModel: DetailsViewModel
    private let contentView = DetailsContentView()

    init(book: BookModel, store: BooksStore) {
        self.viewModel = DetailsViewModel(book: book, store: store)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()

        Task {
            await viewModel.load()
            render()
        }
    }

}

private extension DetailsViewController {

    func setup() {
        view.backgroundColor = .white
        view.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func bind() {
        contentView.onSaveTapped = { [weak self] in
            guard let self else { return }
            Task {
                await self.viewModel.onSaveTapped()
                self.render()
            }
        }
    }

    func render() {
        contentView.configure(
            title: viewModel.titleText,
            author: viewModel.authorText,
            buttonTitle: viewModel.buttonTitle
        )
    }
}
