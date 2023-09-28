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
    func courseDidReceive(with coursesData: CourseListDataStore)
}

final class CourseListInteractor: CourseListInteractorInputProtocol {
    
    private unowned let presenter: CourseListInteractorOutputProtocol
    
    init(presenter: CourseListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchCourses() {
        NetworkManager.shared.fetchData { [unowned self] courses in
            let coursesData = CourseListDataStore(courses: courses)
            presenter.courseDidReceive(with: coursesData)
        }
    }
}
