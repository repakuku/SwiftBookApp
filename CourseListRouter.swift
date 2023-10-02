//
//  CourseListRouter.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/27/23.
//

import Foundation

protocol CourseListRouterInputProtocol {
    init(view: CourseListViewController)
    func openCourseDetailsViewController(with course: Course)
}

final class CourseListRouter: CourseListRouterInputProtocol {
    private unowned let view: CourseListViewController
    
    init(view: CourseListViewController) {
        self.view = view
    }
    
    func openCourseDetailsViewController(with course: Course) {
        let courseDetailsVC = CourseDetailsViewController()
        courseDetailsVC.course = course
        view.navigationController?.pushViewController(courseDetailsVC, animated: true)
    }
}
