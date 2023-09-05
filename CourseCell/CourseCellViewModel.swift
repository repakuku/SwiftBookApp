//
//  CourseCellViewModel.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/5/23.
//

import Foundation

protocol CourseCellViewModelProtocol {
    var courseName: String { get }
    var imageData: Data? { get }
    init(course: Course)
}

final class CourseCellViewModel: CourseCellViewModelProtocol {

    var courseName: String {
        course.name
    }
    
    var imageData: Data? {
        NetworkManager.shared.fetchImageData(from: course.imageUrl)
    }
    
    private var course: Course
    
    init(course: Course) {
        self.course = course
    }
}
