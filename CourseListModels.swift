//
//  CourseListModels.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 10/3/23.
//
import Foundation

typealias CourseCellViewModel = CourseList.ShowCourses.ViewModel.CourseCellViewModel

protocol CourseCellViewModelProtocol {
    var height: Double { get }
    var courseName: String { get }
    var imageData: Data? { get }
    init(course: Course)
}

enum CourseList {
    
    enum ShowCourses {
        struct Response {
            let courses: [Course]
        }
        
        struct ViewModel {
            struct CourseCellViewModel: CourseCellViewModelProtocol {
                var height: Double {
                    100
                }
                
                var courseName: String {
                    course.name
                }
                
                var imageData: Data? {
                    NetworkManager.shared.fetchImageData(from: course.imageUrl)
                }
                
                private let course: Course
                
                init(course: Course) {
                    self.course = course
                }
                
                
            }
            
            let rows: [CourseCellViewModelProtocol]
        }
    }
}
