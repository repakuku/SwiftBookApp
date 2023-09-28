//
//  CourseListRouter.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/27/23.
//

import Foundation

protocol CourseListRouterInputProtocol {
    init(view: CourseListViewInputProtocol)
    
}

final class CourseListRouter: CourseListRouterInputProtocol {
    private unowned let view: CourseListViewInputProtocol
    
    init(view: CourseListViewInputProtocol) {
        self.view = view
    }
    
    
}
