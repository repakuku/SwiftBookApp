//
//  CourseListInteractor.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/27/23.
//

protocol CourseListBusinessLogic {
    func fetchCourses()
}

protocol CourseListDataStore {
    var courses: [Course]? { get }
}

final class CourseListInteractor: CourseListBusinessLogic, CourseListDataStore {

    var courses: [Course]?
    var presenter: CourseListPresentationLogic?
    var worker: CourseListWorker?
    
    func fetchCourses() {
        worker = CourseListWorker()
        courses = worker?.getCourses()
        
        let response = CourseList.ShowCourses.Response(courses: courses ?? [])
        presenter?.presentCourses(response: response)
    }
}
