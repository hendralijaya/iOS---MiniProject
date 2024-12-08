//
//  HomeViewController.swift
//  MiniProject
//
//  Created by hendra on 05/12/24.
//

import UIKit
import Combine

class MenuListViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var viewModel: MenuListViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    private var toast: LoadingToast?
    private let refreshControl = UIRefreshControl()
    
    private var noteList: [MenuModel] = []
    
    private let didLoadPublisher = PassthroughSubject<Void, Never>()
    private let searchTextSubject = PassthroughSubject<String, Never>()
    
    private var menuItems: [MenuModel] = []
    private var filteredMenuItems: [MenuModel] = []
    private var categories: [String] = []
    private var activeCategories: Set<String> = []
    
    private var categoryButtons: [UIButton] = []
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    private var collectionView: UICollectionView!
    
    static func create(with viewModel: MenuListViewModel) -> MenuListViewController {
        let vc = MenuListViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose Your Menu"
        setupSearchBar()
        setupCollectionView()
        bindViewModel()
        didLoadPublisher.send(())
    }
    
    private func handleState(_ state: DataState<[MenuModel]>) {
        switch state {
        case .initiate, .loading:
            if toast == nil {
                toast = LoadingToast()
                toast?.setColor(foreground: .white, background: .black.withAlphaComponent(0.8))
                toast?.show(in: self.view)
            }
            break
        case .success(let data):
            toast?.hide()
            toast = nil
            
            self.menuItems = data
            self.categories = Array(Set(data.map { $0.strArea })).sorted()
            self.activeCategories = []
            self.addCategoryButtons()
            self.applyFilters()
        case .failed(let error):
            toast?.hide()
            toast = nil
            
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        case .inProgress(progress: _):
            break
        }
    }
    
    private func bindViewModel() {
        let input = MenuListViewModel.Input(
            didLoad: didLoadPublisher.eraseToAnyPublisher(),
            searchText: searchTextSubject.eraseToAnyPublisher()
        )
        viewModel.bind(input)
        
        viewModel.output.$result
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleState(state)
            }
            .store(in: &cancellables)
    }
    
    private func applyFilters() {
        if activeCategories.isEmpty {
            filteredMenuItems = menuItems
        } else {
            filteredMenuItems = menuItems.filter { activeCategories.contains($0.strArea) }
        }
        
        collectionView.reloadData()
    }
    
    private func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        // Accessibility
        searchBar.isAccessibilityElement = true
        searchBar.accessibilityLabel = "Search bar"
        searchBar.accessibilityHint = "Enter text to search for menu items."

        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ? UIColor.systemGray6 : UIColor.white
            }
            searchBar.searchTextField.textColor = UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
            }
            searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
                string: "Search...",
                attributes: [.foregroundColor: UIColor { traitCollection in
                    traitCollection.userInterfaceStyle == .dark ? UIColor.lightGray : UIColor.darkGray
                }]
            )
        } else {
            searchBar.searchTextField.backgroundColor = UIColor.white
            searchBar.searchTextField.textColor = UIColor.black
            searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
                string: "Search...",
                attributes: [.foregroundColor: UIColor.darkGray]
            )
        }

        self.view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])

        setupCategoryButtonsContainer(below: searchBar)
    }
    
    private func setupCategoryButtonsContainer(below searchBar: UISearchBar) {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        self.view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            scrollView.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        addCategoryButtons()
    }
    
    private func addCategoryButtons() {
        categoryButtons.forEach { $0.removeFromSuperview() }
        categoryButtons = []

        for category in categories {
            let button = UIButton(type: .system)
            button.setTitle(category, for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.systemBlue.cgColor
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
            
            button.accessibilityLabel = category
            button.accessibilityHint = "Filters the menu to show only \(category) items."
            button.accessibilityTraits = .button
            
            button.isSelected = false
            button.backgroundColor = .clear
            
            categoryButtons.append(button)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc private func categoryButtonTapped(_ sender: UIButton) {
        guard let category = sender.titleLabel?.text else { return }
        
        if sender.isSelected {
            activeCategories.remove(category)
            sender.isSelected = false
            sender.backgroundColor = .clear
        } else {
            activeCategories.insert(category)
            sender.isSelected = true
            sender.backgroundColor = .systemBlue
        }
        
        applyFilters()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true

        collectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: MenuItemCell.identifier)

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = menuItems[indexPath.item]
        let detailViewController = DetailMenuViewController()
        detailViewController.configure(with: selectedItem)
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(detailViewController, animated: true)
        
        UIAccessibility.post(notification: .announcement, argument: "Navigating to \(selectedItem.strMeal) details.")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMenuItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCell.identifier, for: indexPath) as? MenuItemCell else {
            fatalError("Unable to dequeue MenuItemCell")
        }
        let item = filteredMenuItems[indexPath.item]
        cell.configure(with: item)
        
        cell.isAccessibilityElement = true
        cell.accessibilityLabel = item.strMeal
        cell.accessibilityHint = "Double-tap to view details about \(item.strMeal)."
        
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing: CGFloat = 16
        let numberOfItemsPerRow: CGFloat = 2
        
        let width = (collectionView.bounds.width - (numberOfItemsPerRow - 1) * totalSpacing) / numberOfItemsPerRow
        let height = width * 1.2
        
        return CGSize(width: width, height: height)
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTextSubject.send(searchText)
    }
}
