//
//  CourseDetailsModels.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 10/2/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
import Foundation

typealias CourseDetailsRequest = CourseDetails.ShowCourseDetails.Request
typealias CourseDetailsResponse = CourseDetails.ShowCourseDetails.Response
typealias CourseDetailsViewModel = CourseDetails.ShowCourseDetails.ViewModel

typealias CourseDetailsImageResponse = CourseDetails.ShowCourseDetailsImage.Response
typealias CourseDetailsImageViewModel = CourseDetails.ShowCourseDetailsImage.ViewModel

typealias CourseDetailsFavoriteStatusResponse = CourseDetails.setFavoriteStatus.Response
typealias CourseDetailsFavoriteStatusViewModel = CourseDetails.setFavoriteStatus.ViewModel

enum CourseDetails {
 
    // MARK: Use cases
    enum ShowCourseDetails {
        struct Request {
            let course: Course
        }
        
        struct Response {
            let courseName: String?
            let numberOfLessons: Int?
            let numberOfTests: Int?
        }
        
        struct ViewModel {
            let courseName: String
            let numberOfLessons: String
            let numberOfTests: String
        }
    }
    
    enum ShowCourseDetailsImage {
        struct Response {
            let imageData: Data?
        }
        
        struct ViewModel {
            let imageData: Data
        }
    }
    
    enum setFavoriteStatus {
        struct Response {
            let isFavorite: Bool
        }
        
        struct ViewModel {
            let isFavorite: Bool
        }
    }
}
