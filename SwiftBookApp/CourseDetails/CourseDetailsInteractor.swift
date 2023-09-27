//
//  CourseDetailsInteractor.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/26/23.
//

import Foundation

protocol CourseDetailsInteractorInputProtocol {
    var isFavorite: Bool { get }
    init(presenter: CourseDetailsInteractorOutputProtocol, course: Course)
    func provideCourseDetailsData()
    func toggleFavoriteStatus()
}

protocol CourseDetailsInteractorOutputProtocol: AnyObject {
    func receiveCourseDetailsData(courseDetails: CourseDetailsDataStore)
    func receiveFavoriteStatus(with status: Bool)
}

final class CourseDetailsInteractor: CourseDetailsInteractorInputProtocol {
    var isFavorite: Bool {
        get {
            DataManager.shared.getFavoriteStatus(for: course.name)
        } set {
            DataManager.shared.setFavoriteStatus(for: course.name, with: newValue)
        }
    }
    
    private let course: Course
    
    unowned private var presenter: CourseDetailsInteractorOutputProtocol
    
    init(presenter: CourseDetailsInteractorOutputProtocol, course: Course) {
        self.presenter = presenter
        self.course = course
    }
    
    func provideCourseDetailsData() {
        DispatchQueue.global().async { [unowned self] in
            let imageData = NetworkManager.shared.fetchImageData(from: course.imageUrl)
            
            DispatchQueue.main.async { [unowned self] in
                let courseDetailsDataStore = CourseDetailsDataStore(
                    courseName: course.name,
                    numberOfLessons: course.numberOfLessons,
                    numberOfTests: course.numberOfTests,
                    imageData: imageData,
                    isFavorite: isFavorite
                )
                
                presenter.receiveCourseDetailsData(courseDetails: courseDetailsDataStore)
            }
        }
    }
    
    func toggleFavoriteStatus() {
        isFavorite.toggle()
        presenter.receiveFavoriteStatus(with: isFavorite)
    }
}
