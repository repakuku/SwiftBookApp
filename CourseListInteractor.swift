//
//  CourseListInteractor.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/27/23.
//

import Foundation

protocol CourseListInteractorInputProtocol {
    init(presenter: CourseListInteractorOutputProtocol)
    func fetchCourses()
}

protocol CourseListInteractorOutputProtocol: AnyObject {
    func receiveCoursesData(coursesData: CourseListDataStore)
}

final class CourseListInteractor: CourseListInteractorInputProtocol {
    
    private unowned var presenter: CourseListInteractorOutputProtocol
    
    init(presenter: CourseListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchCourses() {
        NetworkManager.shared.fetchData { [unowned self] courses in
            let courseListDataStore = CourseListDataStore(courses: courses)
            presenter.receiveCoursesData(coursesData: courseListDataStore)
        }
    }
}
