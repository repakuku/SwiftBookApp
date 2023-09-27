//
//  CourseCell.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/1/23.
//

import UIKit

final class CourseCell: UITableViewCell {
    
    var viewModel: CourseCellViewModelProtocol! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = viewModel.courseName
            
            DispatchQueue.global().async { [unowned self] in
                guard let imageData = viewModel.imageData else { return }
                
                DispatchQueue.main.async { [unowned self] in
                    content.image = UIImage(data: imageData)
                    contentConfiguration = content
                }
            }
            
        }
    }
}
