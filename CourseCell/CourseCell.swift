//
//  CourseCell.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/1/23.
//

import UIKit

final class CourseCell: UITableViewCell {
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    var viewModel: CourseCellViewModelProtocol! {
        didSet {
            contentView.addSubview(activityIndicator)
            
            NSLayoutConstraint.activate(
                [
                    activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
                ]
            )
            
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
    }
}
