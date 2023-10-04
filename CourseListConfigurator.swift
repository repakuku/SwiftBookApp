//
//  CourseListConfigurator.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/27/23.
//

final class CourseListConfigurator {
    static let shared = CourseListConfigurator()
    
    private init() {}
    
    func configure(withView viewController: CourseListViewController) {
        let interactor = CourseListInteractor()
        let presenter = CourseListPresenter()
        let router = CourseListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}
