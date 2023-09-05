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
        guard let imageData = NetworkManager.shared.fetchImageData(from: course.imageUrl) else { return }
        content.image = UIImage(data: imageData)
        contentConfiguration = content
    }
}
