//
//  CourseDetailsViewController.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 8/30/23.
//

import UIKit

// Get from Presenter
protocol CourseDetailsViewInputProtocol: AnyObject {
    func displayCourseName(with title: String)
    func displayNumberOfLessons(with title: String)
    func displayNumberOfTests(with title: String)
    func displayCourseImage(with imageData: Data)
    func displayImageForFavoriteButton(with status: Bool)
}

// Send to Presenter
protocol CourseDetailsViewOutputProtocol {
    init(view: CourseDetailsViewInputProtocol)
    func showDetails()
    func favoriteButtonPressed()
}

final class CourseDetailsViewController: UIViewController {
    // Presenter
    var presenter: CourseDetailsViewOutputProtocol!
    
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
            presenter.favoriteButtonPressed()
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
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = courseImage.center
        return activityIndicator
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
        
        courseImage.addSubview(activityIndicator)
        
        setupConstraints()
        
        // Informing the Presenter to show the details information
        presenter.showDetails()
    }
    
    // MARK: - Setup UI
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
        
        NSLayoutConstraint.activate(
            [
                activityIndicator.centerXAnchor.constraint(equalTo: courseImage.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: courseImage.centerYAnchor)
            ]
        )
    }
}

// MARK: - CourseDetailsViewInputProtocol
extension CourseDetailsViewController: CourseDetailsViewInputProtocol {
    func displayCourseName(with title: String) {
        courseNameLabel.text = title
    }
    
    func displayNumberOfLessons(with title: String) {
        numberOfLessonsLabel.text = title
    }
    
    func displayNumberOfTests(with title: String) {
        numberOfTestsLabel.text = title
    }
    
    func displayCourseImage(with imageData: Data) {
        courseImage.image = UIImage(data: imageData)
        activityIndicator.stopAnimating()
    }
    
    func displayImageForFavoriteButton(with status: Bool) {
        favoriteButton.tintColor = status ? .systemRed : .systemGray
    }
}
