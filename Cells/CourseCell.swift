//
//  CourseCell.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/1/23.
//

import UIKit

class CourseCell: UITableViewCell {
    
    func configure(with course: Course) {
        var content = defaultContentConfiguration()
        content.text = course.name
        
        DispatchQueue.global().async {
            guard let imageData = ImageManager.shared.fetchImageData(from: course.imageUrl) else { return }
            DispatchQueue.main.async {
                content.image = UIImage(data: imageData)
                self.contentConfiguration = content
            }
        }
        contentConfiguration = content
    }
}
