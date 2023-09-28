//
//  CourseListViewController.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 8/30/23.
//

import UIKit

protocol CourseListViewInputProtocol: AnyObject {
    func display(courses: [Course])
}

protocol CourseListViewOutputProtocol {
    init(view: CourseListViewInputProtocol)
    func viewDidLoad()
}

final class CourseListViewController: UIViewController {
    
    var presenter: CourseListPresenter!
    
    // MARK: - Private Properties
    private let cellID = "course"
    private let configurator: CourseListConfiguratorInputProtocol = CourseListConfigurator()
    private var courses: [Course] = []
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CourseCell.self, forCellReuseIdentifier: cellID)
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(withView: self)
        
        view.addSubview(tableView)
        setupConstraints()
        setupNavigationBar()
        
        presenter.viewDidLoad()
    }
    
    // MARK: - Setup UI
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
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                
            ]
        )
    }
}

// MARK: - UITableViewDataSource
extension CourseListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let cell = cell as? CourseCell else { return UITableViewCell() }
        let course = courses[indexPath.row]
        cell.viewModel = CourseCellViewModel(course: course)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CourseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let courseDetailsVC = CourseDetailsViewController()
        courseDetailsVC.course = courses[indexPath.row]
        navigationController?.pushViewController(courseDetailsVC, animated: true)
    }
}

// MARK: - CourseListViewinputProtocol
extension CourseListViewController: CourseListViewInputProtocol {
    func display(courses: [Course]) {
        self.courses = courses
        tableView.reloadData()
    }
}
