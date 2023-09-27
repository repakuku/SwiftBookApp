//
//  CourseDetailsConfigurator.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/26/23.
//

import Foundation

protocol CourseDetailsConfiguratorInputProtocol {
    func configure(withView view: CourseDetailsViewController, and course: Course)
}

final class CourseDetailsConfigurator: CourseDetailsConfiguratorInputProtocol {
    func configure(withView view: CourseDetailsViewController, and course: Course) {
        let presenter = CourseDetailsPresenter(view: view)
        view.presenter = presenter
    }
}
