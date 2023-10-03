//
//  CourseDetailsInteractor.swift
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

protocol CourseDetailsBusinessLogic {
    func provideCourseDetails(request: CourseDetailsRequest)
    func provideCourseDetailsImage()
    func toggleFavoriteStatus()
}

protocol CourseDetailsDataStore {
    var course: Course? { get }
}

class CourseDetailsInteractor: CourseDetailsBusinessLogic, CourseDetailsDataStore {
    var course: Course?
    var presenter: CourseDetailsPresentationLogic?
    var worker: CourseDetailsWorker?
    
    var isFavorite: Bool {
        get {
            DataManager.shared.getFavoriteStatus(for: course?.name ?? "")
        } set {
            DataManager.shared.setFavoriteStatus(for: course?.name ?? "", with: newValue)
        }
    }
    
    func provideCourseDetails(request: CourseDetailsRequest) {
        course = request.course
        
        let response = CourseDetailsResponse(
            courseName: course?.name,
            numberOfLessons: course?.numberOfLessons,
            numberOfTests: course?.numberOfTests
        )
        presenter?.presentCourseDetails(response: response)
    }
    
    func provideCourseDetailsImage() {
        DispatchQueue.global().async { [weak self] in
            self?.worker = CourseDetailsWorker()
            let imageData = self?.worker?.getImageData(from: self?.course?.imageUrl)
            DispatchQueue.main.async { [weak self] in
                let response = CourseDetailsImageResponse(imageData: imageData)
                self?.presenter?.presentCourseDetailsImage(response: response)
            }
        }
    }
    
    func toggleFavoriteStatus() {
        isFavorite.toggle()
        let response = CourseDetailsFavoriteStatusResponse(isFavorite: isFavorite)
        presenter?.presentFavoriteStatus(response: response)
    }
}
