//
//  CourseListRouter.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 10/4/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol CourseListRoutingLogic {
    func routeToCourseDetails()
}

protocol CourseListDataPassing {
    var dataStore: CourseListDataStore? { get }
}

class CourseListRouter: CourseListRoutingLogic, CourseListDataPassing {
    
    weak var viewController: CourseListViewController?
    var dataStore: CourseListDataStore?
    
    // MARK: Routing
    func routeToCourseDetails() {
        guard let dataStore else { return }
        let destinationVC = CourseDetailsViewController()
        guard var destinationDS = destinationVC.router?.dataStore else { return }
        passDataToCourseDetails(source: dataStore, destination: &destinationDS)
        navigateToCourseDetails(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    func navigateToCourseDetails(source: CourseListViewController, destination: CourseDetailsViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Passing data
    func passDataToCourseDetails(source: CourseListDataStore, destination: inout CourseDetailsDataStore) {
        guard let indexPath = viewController?.tableView.indexPathForSelectedRow else {
            return
        }
        destination.course = source.courses[indexPath.row]
    }
}
