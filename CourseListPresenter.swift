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
    private var coursesData: CourseListDataStore?
    
    init(view: CourseListViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchCourses()
    }
    
    func didTapCell(at indexPath: IndexPath) {
        guard let course = coursesData?.courses[indexPath.row] else { return }
        router.openCourseDetailsViewController(with: course)
    }
}

// MARK: - CourseListInteractorOutputProtocol
extension CourseListPresenter: CourseListInteractorOutputProtocol {
    func courseDidReceive(with coursesData: CourseListDataStore) {
        self.coursesData = coursesData
        let section = CourseSectionViewModel()
        coursesData.courses.forEach { section.rows.append(CourseCellViewModel(course: $0)) }
        view.reloadData(for: section)
    }
}
