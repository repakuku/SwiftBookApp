//
//  CourseCell.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/1/23.
//

import UIKit

protocol CellModelRepresentable {
    var viewModel: CourseCellViewModelProtocol? { get }
}

final class CourseCell: UITableViewCell, CellModelRepresentable {
    
    var viewModel: CourseCellViewModelProtocol? {
        didSet {
            updateView()
        }
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private func updateView() {
        contentView.addSubview(activityIndicator)
        setupConstraints()
        
        guard let viewModel = viewModel as? CourseCellViewModel else { return }
        
        DispatchQueue.global().async { [unowned self] in
            guard let imageData = viewModel.imageData else { return }
            
            DispatchQueue.main.async { [unowned self] in
                var content = defaultContentConfiguration()
                content.text = viewModel.courseName
                content.image = UIImage(data: imageData)
                contentConfiguration = content
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ]
        )
    }
}
