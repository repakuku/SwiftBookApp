//
//  CourseListPresenter.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/27/23.
//

import Foundation

struct CourseListDataStore {
    let courses: [Course]
}

final class CourseListPresenter: CourseListViewOutputProtocol {
    var interactor: CourseListInteractorInputProtocol!
    var router: CourseListRouterInputProtocol!
    
    private unowned let view: CourseListViewInputProtocol
    
    init(view: CourseListViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchCourses()
    }
}

// MARK: - CourseListInteractorOutputProtocol
extension CourseListPresenter: CourseListInteractorOutputProtocol {
    func courseDidReceive(with coursesData: CourseListDataStore) {
        view.display(courses: coursesData.courses)
    }
}
