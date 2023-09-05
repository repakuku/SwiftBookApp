//
//  CourseCellViewModel.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/5/23.
//

import Foundation

protocol CourseCellViewModelProtocol {
    var course: Course { get }
    var name: String { get }
    var imageData: Data? { get }
}

final class CourseCellViewModel: CourseCellViewModelProtocol {
    var course: Course
    
    var name: String {
        course.name
    }
    
    var imageData: Data? {
        fetchImageData()
    }
    
    private var url: URL {
        course.imageUrl
    }
    
    init(course: Course) {
        self.course = course
    }
    
    private func fetchImageData() -> Data? {
        NetworkManager.shared.fetchImageData(from: url)
    }
}
