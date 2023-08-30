//
//  CourseDetailsViewController.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 8/30/23.
//

import UIKit

final class CourseDetailsViewController: UIViewController {
    
    // MARK: - UIViews
    
    private lazy var courseNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.textAlignment = .center
        label.font = UIFont(name: "Menlo-Regular", size: 23)
        return label
    }()
    
    private lazy var numberOfLessonsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Number of lessons:"
        label.font = UIFont(name: "GillSans-SemiBold", size: 17)
        return label
    }()
    
    private lazy var numberOfTestsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Number of tests:"
        label.font = UIFont(name: "GillSans-SemiBold", size: 17)
        return label
    }()
    
    private lazy var courseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "graduationcap")
        return imageView
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "heart.fill")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .systemRed
        // Heart size
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
        
        setupConstraints()
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
    }
}
