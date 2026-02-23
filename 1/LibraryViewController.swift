//
//  ViewController.swift
//  1
//
//  Created by Elena Datso on 2026-02-19.
//

import UIKit

class LibraryViewController: UIViewController {
    
    private let vm: LibraryViewModel
    private lazy var searchField = SearchView(
        onTap: { [weak self] text in
            guard let self, !text.isEmpty else { return }
            self.vm.search(query: text)
        },
        onText: { _ in }
    )
    
    private lazy var cv: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 130)
        
        let vw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vw.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCollectionViewCell")
        vw.dataSource = self
        
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setup()
        vm.delegate = self
        //Task {
            //await vm.search(query: "pomoika")
        //}
    }
    
    init(viewModel: LibraryViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LibraryViewController: LibraryViewModelDelegate {
    func didFinish() {
        cv.reloadData()
    }
    func didFail(error: Error) {
        print(error)
    }
}
extension LibraryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = vm.books.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = vm.books[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        cell.item = item
        cell.accessibilityIdentifier = "bookCell_\(indexPath.item)"
        return cell
    }
}
private extension LibraryViewController {
    func setup() {
        self.view.backgroundColor = .white
        cv.accessibilityIdentifier = "booksCollectionView"
        searchField.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(searchField)
        self.view.addSubview(cv)
        
        NSLayoutConstraint.activate([
            
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchField.heightAnchor.constraint(equalToConstant: 80),
            
            cv.topAnchor.constraint(equalTo: searchField.bottomAnchor),
            cv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cv.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cv.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    

}
