//
//  CourseListPresenter.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/27/23.
//

protocol CourseListPresentationLogic {
    func presentCourses(response: CourseList.ShowCourses.Response)
}

final class CourseListPresenter: CourseListPresentationLogic {
    
    weak var viewController: CourseListDisplayLogic?
    
    func presentCourses(response: CourseList.ShowCourses.Response) {
        
    }
}
