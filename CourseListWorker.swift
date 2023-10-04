//
//  CourseListWorker.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 10/3/23.
//

final class CourseListWorker {
    func getCourses() -> [Course]? {
        NetworkManager.shared.fetchData()
    }
}
