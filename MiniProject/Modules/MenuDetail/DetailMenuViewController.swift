//
//  DetailMenuViewController.swift
//  MiniProject
//
//  Created by hendra on 05/12/24.
//

import UIKit

class DetailMenuViewController: UIViewController {

    private var menuItem: MenuModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func configure(with item: MenuModel) {
        self.menuItem = item
    }

    private func setupUI() {
        guard let menuItem = menuItem else { return }
        self.title = menuItem.strMeal
        let imageView = UIImageView()
        let descriptionLabel = UILabel()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.text = menuItem.strArea
        descriptionLabel.numberOfLines = 0
        imageView.contentMode = .scaleToFill

        if let url = URL(string: menuItem.strMealThumb) {
            loadImage(from: url, into: imageView)
        }

        view.addSubview(imageView)
        view.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),

            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func loadImage(from url: URL, into imageView: UIImageView) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }.resume()
    }
}
