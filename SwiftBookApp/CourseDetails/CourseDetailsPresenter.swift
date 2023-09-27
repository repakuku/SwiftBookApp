//
//  CourseDetailsPresenter.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/26/23.
//

import Foundation

struct CourseDetailsDataStore {
    let courseName: String
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
        let courseName = courseDetails.courseName
        view.displayCourseName(courseName)
    }
}
