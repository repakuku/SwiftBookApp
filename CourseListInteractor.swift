//
//  CourseListInteractor.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/27/23.
//

import Foundation

protocol CourseListBusinessLogic {
    func fetchCourses()
}

protocol CourseListDataStore {
    var courses: [Course] { get }
}

final class CourseListInteractor: CourseListBusinessLogic, CourseListDataStore {

    var courses: [Course] = []
    var presenter: CourseListPresentationLogic?
    
    func fetchCourses() {
        NetworkManager.shared.fetchData { [weak self] courses in
            self?.courses = courses
            let response = CourseList.ShowCourses.Response(courses: courses)
            self?.presenter?.presentCourses(response: response)
        }
    }
}
