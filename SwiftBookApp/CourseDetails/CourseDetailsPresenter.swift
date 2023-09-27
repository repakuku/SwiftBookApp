//
//  CourseDetailsPresenter.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/26/23.
//

import Foundation

struct CourseDetailsDataStore {
    let courseName: String
    let numberOfLessons: Int
    let numberOfTests: Int
}

final class CourseDetailsPresenter: CourseDetailsViewOutputProtocol {
    unowned private let view: CourseDetailsViewInputProtocol
    
    var interactor: CourseDetailsInteractorInputProtocol!
    
    init(view: CourseDetailsViewInputProtocol) {
        self.view = view
    }
    
    func showDetails() {
        interactor.provideCourseDetailsData()
    }
}

// MARK: - CourseDetailsInteractorOutputProtocol
extension CourseDetailsPresenter: CourseDetailsInteractorOutputProtocol {
    func receiveCourseDetailsData(courseDetails: CourseDetailsDataStore) {
        let courseNameTitle = courseDetails.courseName
        let numberOfLessonsTitle = "Number of lessons: \(courseDetails.numberOfLessons)"
        let numberOfTestsTitle = "Number of tests: \(courseDetails.numberOfTests)"
        view.displayCourseName(with: courseNameTitle)
        view.displayNumberOfLessons(with: numberOfLessonsTitle)
        view.displayNumberOfTests(with: numberOfTestsTitle)
    }
}
