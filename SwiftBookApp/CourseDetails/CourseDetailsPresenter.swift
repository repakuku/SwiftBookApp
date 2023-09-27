//
//  CourseDetailsPresenter.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/26/23.
//

import Foundation

// Storing values in properties defines the data that needs to be displayed
struct CourseDetailsDataStore {
    let courseName: String
    let numberOfLessons: Int
    let numberOfTests: Int
    var imageData: Data?
    let isFavorite: Bool
}

final class CourseDetailsPresenter: CourseDetailsViewOutputProtocol {
    var interactor: CourseDetailsInteractorInputProtocol!
    
    unowned private let view: CourseDetailsViewInputProtocol
    
    init(view: CourseDetailsViewInputProtocol) {
        self.view = view
    }
    
    func showDetails() {
        interactor.provideCourseDetailsData()
        interactor.provideCourseImageData()
    }
    
    func favoriteButtonPressed() {
        interactor.toggleFavoriteStatus()
    }
}

// MARK: - CourseDetailsInteractorOutputProtocol
extension CourseDetailsPresenter: CourseDetailsInteractorOutputProtocol {
    func receiveCourseDetailsData(courseDetails: CourseDetailsDataStore) {
        let courseNameTitle = courseDetails.courseName
        let numberOfLessonsTitle = "Number of lessons: \(courseDetails.numberOfLessons)"
        let numberOfTestsTitle = "Number of tests: \(courseDetails.numberOfTests)"
        
        view.displayCourseName(with: courseNameTitle)
        view.displayNumberOfLessons(with: numberOfLessonsTitle)
        view.displayNumberOfTests(with: numberOfTestsTitle)
        view.displayImageForFavoriteButton(with: courseDetails.isFavorite)
        

    }
    
    func receiveCourseImageData(imageData: Data?) {
        guard let imageData else { return }
        view.displayCourseImage(with: imageData)
    }
    
    func receiveFavoriteStatus(with status: Bool) {
        view.displayImageForFavoriteButton(with: status)
    }
}
