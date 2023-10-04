//
//  CourseDetailsPresenter.swift
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

protocol CourseDetailsPresentationLogic {
    func presentCourseDetails(response: CourseDetailsResponse)
    func presentCourseDetailsImage(response: CourseDetailsImageResponse)
    func provideFavoriteStatus(response: CourseDetailsFavoriteStatusResponse)
}

class CourseDetailsPresenter: CourseDetailsPresentationLogic {
    
    weak var viewController: CourseDetailsDisplayLogic?
    
    func presentCourseDetails(response: CourseDetailsResponse) {
        let numberOfLessons = "Number of lessons: \(response.numberOfLessons ?? 0)"
        let numberOfTests = "Number of tests: \(response.numberOfTests ?? 0)"
        
        let viewModel = CourseDetailsViewModel(
            courseName: response.courseName ?? "",
            numberOfLessons: numberOfLessons,
            numberOfTests: numberOfTests,
            isFavorite: response.isFavorite
        )
        viewController?.displayCourseDetails(viewModel: viewModel)
    }
    
    func presentCourseDetailsImage(response: CourseDetailsImageResponse) {
        let viewModel = CourseDetailsImageViewModel(imageData: response.imageData ?? Data())
        viewController?.displayCourseDetailsImage(viewModel: viewModel)
    }
    
    func provideFavoriteStatus(response: CourseDetailsFavoriteStatusResponse) {
        let viewModel = CourseDetailsFavoriteStatusViewModel(isFavorite: response.isFavorite)
        viewController?.displayFavoriteButtonStatus(viewModel: viewModel)
    }
}
