//
//  CourseDetailsViewController.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 8/30/23.
//

import UIKit

final class CourseDetailsViewController: UIViewController {
    
    var course: Course!
    
    private var viewModel: CourseDetailsViewModelProtocol! {
        didSet {
            courseNameLabel.text = viewModel.courseName
            numberOfLessonsLabel.text = viewModel.numberOfLessons
            numberOfTestsLabel.text = viewModel.numberOfTests
        }
    }
    
    private var isFavorite = false
    
    // MARK: - UIViews
    private lazy var courseNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Menlo-Regular", size: 23)
        return label
    }()
    
    private lazy var numberOfLessonsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GillSans-SemiBold", size: 17)
        return label
    }()
    
    private lazy var numberOfTestsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GillSans-SemiBold", size: 17)
        return label
    }()
    
    private lazy var courseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var favoriteButton: UIButton = {
        let action = UIAction { [unowned self] _ in
            isFavorite.toggle()
            setStatusForFavoriteButton()
            DataManager.shared.setFavoriteStatus(for: course.name, with: isFavorite)
        }
        let button = UIButton(configuration: .plain(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "heart.fill")
        button.setImage(image, for: .normal)
        
        button.tintColor = .systemGray
        
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30), scale: .default)
        button.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        
        return button
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSubview(
            courseNameLabel,
            courseImage,
            numberOfLessonsLabel,
            numberOfTestsLabel,
            favoriteButton
        )
        
        viewModel = CourseDetailsViewModel(course: course)
        
        setupConstraints()
        loadFavoriteStatus()
        setStatusForFavoriteButton()
        
        fetchCourseImage()
    }
    
    // MARK: - Setup UI
    private func fetchCourseImage() {
        DispatchQueue.global().async { [unowned self] in
            guard let imageData = NetworkManager.shared.fetchImageData(from: course.imageUrl) else { return }
            
            DispatchQueue.main.async { [unowned self] in
                courseImage.image = UIImage(data: imageData)
            }
        }
    }
    
    private func setStatusForFavoriteButton() {
        favoriteButton.tintColor = isFavorite ? .systemRed : .systemGray
    }
    
    private func loadFavoriteStatus() {
        isFavorite = DataManager.shared.getFavoriteStatus(for: course.name)
    }
    
    private func setupSubview(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                courseNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                courseNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                courseNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                courseImage.topAnchor.constraint(equalTo: courseNameLabel.bottomAnchor, constant: 27),
                courseImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
                courseImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
                courseImage.heightAnchor.constraint(equalToConstant: 203)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                numberOfLessonsLabel.topAnchor.constraint(equalTo: courseImage.bottomAnchor, constant: 48),
                numberOfLessonsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                numberOfLessonsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                numberOfTestsLabel.topAnchor.constraint(equalTo: numberOfLessonsLabel.bottomAnchor, constant: 20),
                numberOfTestsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                numberOfTestsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                favoriteButton.widthAnchor.constraint(equalToConstant: 60),
                favoriteButton.heightAnchor.constraint(equalToConstant: 60),
                favoriteButton.trailingAnchor.constraint(equalTo: courseImage.trailingAnchor),
                favoriteButton.bottomAnchor.constraint(equalTo: courseImage.bottomAnchor)
            ]
        )
    }
}
