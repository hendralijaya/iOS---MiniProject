//
//  MenuItemCell.swift
//  MiniProject
//
//  Created by hendra on 06/12/24.
//

import UIKit

class MenuItemCell: UICollectionViewCell {
    static let identifier = "MenuItemCell"

    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let badgeLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nameLabel.textAlignment = .left

        badgeLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        badgeLabel.textColor = .white
        badgeLabel.textAlignment = .left

        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(badgeLabel)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),

            badgeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            badgeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            badgeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            badgeLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -4),
        ])
    }

    func configure(with item: MenuModel) {
        nameLabel.text = item.strMeal
        badgeLabel.text = item.strArea
        loadImage(from: item.strMealThumb)
    }
    
    private func loadImage(from urlString: String?) {
        self.imageView.image = nil

        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.imageView.image = nil
                }
            }
        }
        task.resume()
    }
}
