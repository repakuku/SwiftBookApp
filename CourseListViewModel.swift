//
//  CourseListViewModel.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/5/23.
//

import Foundation

protocol CourseListViewModelProtocol {
    func fetchCourses(completion: @escaping () -> Void)
    func numberOfRows() -> Int
    func getCourseCellViewModel(for indexPath: IndexPath) -> CourseCellViewModelProtocol
    func getCourseDetailsViewModel(for indexPath: IndexPath) -> CourseDetailsViewModelProtocol
}

final class CourseListViewModel: CourseListViewModelProtocol {
    private var courses: [Course] = []
    
    func fetchCourses(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData { [unowned self] courses in
            self.courses = courses
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        courses.count
    }
    
    func getCourseCellViewModel(for indexPath: IndexPath) -> CourseCellViewModelProtocol {
        CourseCellViewModel(course: courses[indexPath.row])
    }
    
    func getCourseDetailsViewModel(for indexPath: IndexPath) -> CourseDetailsViewModelProtocol {
        CourseDetailsViewModel(course: courses[indexPath.row])
    }
}
