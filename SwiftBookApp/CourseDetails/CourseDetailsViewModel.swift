//
//  CourseDetailsViewModel.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/4/23.
//

import Foundation

protocol CourseDetailsViewModelProtocol {
    var courseName: String { get }
    init(course: Course)
}

final class CourseDetailsViewModel: CourseDetailsViewModelProtocol {
    var courseName: String {
        course.name
    }
    
    private let course: Course
    
    init(course: Course) {
        self.course = course
    }
}
