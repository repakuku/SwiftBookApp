//
//  CourseDetailsViewModel.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/4/23.
//

import Foundation

protocol CourseDetailsViewModelProtocol {
    var courseName: String { get }
    var numberOfLessons: String { get }
    var numberOfTests: String { get }
    init(course: Course)
}

final class CourseDetailsViewModel: CourseDetailsViewModelProtocol {
    var courseName: String {
        course.name
    }
    
    var numberOfLessons: String {
        "Number of lessons: \(course.numberOfLessons)"
    }
    
    var numberOfTests: String {
        "Number of tests: \(course.numberOfTests)"
    }
    
    private let course: Course
    
    init(course: Course) {
        self.course = course
    }
}
