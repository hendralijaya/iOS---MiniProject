//
//  DetailMenuViewController.swift
//  MiniProject
//
//  Created by hendra on 05/12/24.
//

import UIKit
import Kingfisher

class DetailMenuViewController: UIViewController {
    
    private var menuItem: MenuModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    func configure(with item: MenuModel) {
        self.menuItem = item
    }
    
    private func setupUI() {
        guard let menuItem = menuItem else { return }
        self.title = menuItem.strMeal
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        if let url = URL(string: menuItem.strMealThumb) {
            loadImage(from: url, into: imageView)
        }
        
        let descriptionContainer = UIView()
        let descriptionLabel = UILabel()
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionContainer.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.text = menuItem.strArea
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.backgroundColor = .lightGray
        descriptionLabel.textColor = .black
        descriptionLabel.layer.cornerRadius = 10
        descriptionLabel.layer.masksToBounds = true
        
        descriptionContainer.addSubview(descriptionLabel)
        descriptionContainer.layer.cornerRadius = 10
        descriptionContainer.layer.masksToBounds = true
        descriptionContainer.backgroundColor = .lightGray
        
        let ingredientsHeading = UILabel()
        ingredientsHeading.translatesAutoresizingMaskIntoConstraints = false
        ingredientsHeading.text = "Ingredients"
        ingredientsHeading.font = UIFont.boldSystemFont(ofSize: 18)
        ingredientsHeading.textColor = .black
        
        let ingredientsContent = UILabel()
        ingredientsContent.translatesAutoresizingMaskIntoConstraints = false
        ingredientsContent.numberOfLines = 0
        let ingredientsWithMeasures = zip(
            [menuItem.strMeasure1, menuItem.strMeasure2, menuItem.strMeasure3, menuItem.strMeasure4, menuItem.strMeasure5,
             menuItem.strMeasure6, menuItem.strMeasure7, menuItem.strMeasure8, menuItem.strMeasure9, menuItem.strMeasure10,
             menuItem.strMeasure11, menuItem.strMeasure12, menuItem.strMeasure13, menuItem.strMeasure14, menuItem.strMeasure15,
             menuItem.strMeasure16, menuItem.strMeasure17, menuItem.strMeasure18, menuItem.strMeasure19, menuItem.strMeasure20],
            menuItem.ingredients
        ).compactMap { measure, ingredient in
            guard let measure = measure, !measure.isEmpty else { return ingredient }
            return "\(measure) of \(ingredient)"
        }
        ingredientsContent.text = ingredientsWithMeasures.joined(separator: "\n")
        ingredientsContent.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        ingredientsContent.textColor = .darkGray
        
        let instructionsHeading = UILabel()
        instructionsHeading.translatesAutoresizingMaskIntoConstraints = false
        instructionsHeading.text = "Instructions"
        instructionsHeading.font = UIFont.boldSystemFont(ofSize: 18)
        instructionsHeading.textColor = .black
        
        let instructionsContent = UILabel()
        instructionsContent.translatesAutoresizingMaskIntoConstraints = false
        instructionsContent.numberOfLines = 0
        instructionsContent.text = menuItem.strInstructions
        instructionsContent.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        instructionsContent.textColor = .darkGray
        
        let youtubeButton = UIButton(type: .system)
        youtubeButton.translatesAutoresizingMaskIntoConstraints = false
        youtubeButton.setTitle("Available on YouTube", for: .normal)
        youtubeButton.setTitleColor(.systemBlue, for: .normal)
        youtubeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)

        // Add an image to the button
        let youtubeIcon = UIImage(systemName: "play.rectangle.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        youtubeButton.setImage(youtubeIcon, for: .normal)
        youtubeButton.imageView?.contentMode = .scaleAspectFit
        youtubeButton.contentHorizontalAlignment = .leading
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8)
        youtubeButton.configuration = configuration
        
        youtubeButton.addTarget(self, action: #selector(openYouTube), for: .touchUpInside)

        // Add Subviews
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionContainer)
        contentView.addSubview(ingredientsHeading)
        contentView.addSubview(ingredientsContent)
        contentView.addSubview(instructionsHeading)
        contentView.addSubview(instructionsContent)
        contentView.addSubview(youtubeButton)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            // ScrollView and ContentView Constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            descriptionContainer.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            descriptionContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionContainer.topAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionContainer.bottomAnchor, constant: -8),
            
            ingredientsHeading.topAnchor.constraint(equalTo: descriptionContainer.bottomAnchor, constant: 16),
            ingredientsHeading.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ingredientsHeading.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            ingredientsContent.topAnchor.constraint(equalTo: ingredientsHeading.bottomAnchor, constant: 8),
            ingredientsContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ingredientsContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            instructionsHeading.topAnchor.constraint(equalTo: ingredientsContent.bottomAnchor, constant: 16),
            instructionsHeading.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            instructionsHeading.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            instructionsContent.topAnchor.constraint(equalTo: instructionsHeading.bottomAnchor, constant: 8),
            instructionsContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            instructionsContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            instructionsContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            youtubeButton.topAnchor.constraint(equalTo: instructionsContent.bottomAnchor, constant: 0),
            youtubeButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            youtubeButton.heightAnchor.constraint(equalToConstant: 44)

        ])
    }
    
    @objc private func openYouTube() {
        guard let urlString = menuItem?.strYoutube, let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
    private func loadImage(from url: URL, into imageView: UIImageView) {
        imageView.kf.setImage(
            with: url,
            placeholder: LoadingToast() as? Placeholder,
            options: [
                .transition(.fade(0.3)),
                .cacheOriginalImage
            ],
            progressBlock: nil,
            completionHandler: nil
        )
    }
}
