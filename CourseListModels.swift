//
//  CourseListModels.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 10/3/23.
//

enum CourseList {
    
    enum ShowCourses {
        struct Response {
            let courses: [Course]
        }
        
        struct ViewModel {
            let rows: [String]
        }
    }
}
