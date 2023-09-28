//
//  CourseCellViewModel.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/5/23.
//

import Foundation

protocol CourseCellViewModelProtocol {
    var cellHeight: Double { get }
    var courseName: String { get }
    var imageData: Data? { get }
    init(course: Course)
}

protocol CourseSectionViewModelProtocol {
    var rows: [CourseCellViewModelProtocol] { get }
    var numberOfRows: Int { get }
}

final class CourseCellViewModel: CourseCellViewModelProtocol {
    var cellHeight: Double {
        100
    }
    
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

final class CourseSectionViewModel: CourseSectionViewModelProtocol {
    var rows: [CourseCellViewModelProtocol] = []
    
    var numberOfRows: Int {
        rows.count
    }
}
