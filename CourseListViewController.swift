//
//  CourseListViewController.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 8/30/23.
//

import UIKit

protocol CourseListDisplayLogic: AnyObject {
    func displayCourses(viewModel: CourseList.ShowCourses.ViewModel)
}

final class CourseListViewController: UIViewController {
    
    var interactor: CourseListBusinessLogic?
    var router: (CourseListRoutingLogic & CourseListDataPassing)?
    
    // MARK: - Private Properties
    private let cellID = "course"
    private var rows: [CourseCellViewModelProtocol] = []
    
    // MARK: - Views
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CourseCell.self, forCellReuseIdentifier: cellID)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CourseListConfigurator.shared.configure(withView: self )
        
        view.addSubview(tableView)
        setupConstraints()
        setupNavigationBar()
        
        interactor?.fetchCourses()
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
    
    // MARK: - Routing
    
}

// MARK: - UITableViewDataSource
extension CourseListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let cell = cell as? CourseCell else { return UITableViewCell() }
        cell.viewModel = rows[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CourseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.routeToCourseDetails()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rows[indexPath.row].height
    }
}

// MARK: - CourseListDisplayLogic
extension CourseListViewController: CourseListDisplayLogic {
    func displayCourses(viewModel: CourseList.ShowCourses.ViewModel) {
        rows = viewModel.rows
        tableView.reloadData()
    }
}
