//
//  CourseListViewModel.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/5/23.
//

import Foundation

protocol CourseListViewModelProtocol {
    #warning("TODO: courses must be private")
    var courses: [Course] { get }
    func fetchCourses(completion: @escaping () -> Void)
    func numberOfRows() -> Int
    func getCourseCellViewModel(for index: Int) -> CourseCellViewModelProtocol
}

final class CourseListViewModel: CourseListViewModelProtocol {
    var courses: [Course] = []
    
    func fetchCourses(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData { [unowned self] courses in
            self.courses = courses
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        courses.count
    }
    
    func getCourseCellViewModel(for index: Int) -> CourseCellViewModelProtocol {
        CourseCellViewModel(course: courses[index])
    }
}
