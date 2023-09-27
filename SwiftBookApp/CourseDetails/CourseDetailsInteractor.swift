//
//  CourseDetailsInteractor.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/26/23.
//

import Foundation

protocol CourseDetailsInteractorInputProtocol {
    init(presenter: CourseDetailsInteractorOutputProtocol, course: Course)
    func provideCourseDetailsData()
}

protocol CourseDetailsInteractorOutputProtocol: AnyObject {
    func receiveCourseDetailsData(courseDetails: CourseDetailsDataStore)
}

final class CourseDetailsInteractor: CourseDetailsInteractorInputProtocol {
    unowned private var presenter: CourseDetailsInteractorOutputProtocol
    
    private let course: Course
    
    init(presenter: CourseDetailsInteractorOutputProtocol, course: Course) {
        self.presenter = presenter
        self.course = course
    }
    
    func provideCourseDetailsData() {
        let courseDetailsDataStore = CourseDetailsDataStore(
            courseName: course.name,
            numberOfLessons: course.numberOfLessons,
            numberOfTests: course.numberOfTests
        )
        
        presenter.receiveCourseDetailsData(courseDetails: courseDetailsDataStore)
    }
}
