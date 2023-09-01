//
//  CourseListViewController.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 8/30/23.
//

import UIKit

final class CourseListViewController: UITableViewController {
    
    var courses: [Course] = []
    
    private let cellID = "course"
//    private var activityIndicator: UIActivityIndicatorView?
    private let networkManager = NetworkManager.shared
    private let imageManager = ImageManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CourseCell.self, forCellReuseIdentifier: cellID)
        tableView.rowHeight = 100
        
//        activityIndicator = showActivityIndicator(in: view)
        setupNavigationBar()
        
        fetchCourses()
    }
    
    // MARK: - Private Methods
    private func fetchCourses() {
        networkManager.fetchData { [unowned self] courses in
            self.courses = courses
            DispatchQueue.main.async {
//                self.activityIndicator?.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Setup UI
    
//    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
//        let activityIndicator = UIActivityIndicatorView(style: .large)
//        activityIndicator.color = .black
//        activityIndicator.startAnimating()
//        activityIndicator.center = view.center
//        activityIndicator.hidesWhenStopped = true
//        
//        view.addSubview(activityIndicator)
//        
//        return activityIndicator
//    }
    
    private func setupNavigationBar() {
        title = "Courses"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .systemBlue
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

// MARK: - UITableViewDataSource
extension CourseListViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let cell = cell as? CourseCell else { return UITableViewCell() }
        let course = courses[indexPath.row]
        cell.configure(with: course)
        return cell
    }

}

// MARK: - UITableViewDelegate
extension CourseListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let courseDetailsVC = CourseDetailsViewController()
        navigationController?.pushViewController(courseDetailsVC, animated: true)
    }
}
