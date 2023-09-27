//
//  CourseDetailsInteractor.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/26/23.
//

import Foundation

protocol CourseDetailsInteractorInputProtocol {
    var isFavorite: Bool { get }
    var imageData: Data? { get }
    init(presenter: CourseDetailsInteractorOutputProtocol, course: Course)
    func provideCourseDetailsData()
    func provideCourseImageData()
    func toggleFavoriteStatus()
}

protocol CourseDetailsInteractorOutputProtocol: AnyObject {
    func receiveCourseDetailsData(courseDetails: CourseDetailsDataStore)
    func receiveCourseImageData(imageData: Data?)
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
    
    var imageData: Data?
    
    private let course: Course
    
    unowned private var presenter: CourseDetailsInteractorOutputProtocol
    
    init(presenter: CourseDetailsInteractorOutputProtocol, course: Course) {
        self.presenter = presenter
        self.course = course
    }
    
    func provideCourseDetailsData() {
        let courseDetailsDataStore = CourseDetailsDataStore(
            courseName: course.name,
            numberOfLessons: course.numberOfLessons,
            numberOfTests: course.numberOfTests,
            isFavorite: isFavorite
        )
        
        presenter.receiveCourseDetailsData(courseDetails: courseDetailsDataStore)
        
        
    }
    
    func provideCourseImageData() {
        DispatchQueue.global().async { [unowned self] in
            let imageData = NetworkManager.shared.fetchImageData(from: course.imageUrl)
            
            DispatchQueue.main.async { [unowned self] in
                presenter.receiveCourseImageData(imageData: imageData)
            }
        }
    }
    
    func toggleFavoriteStatus() {
        isFavorite.toggle()
        presenter.receiveFavoriteStatus(with: isFavorite)
    }
}
