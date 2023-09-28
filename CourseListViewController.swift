//
//  CourseListViewController.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 8/30/23.
//

import UIKit

protocol CourseListViewInputProtocol: AnyObject {
    func reloadData(for section: CourseSectionViewModel)
}

protocol CourseListViewOutputProtocol {
    init(view: CourseListViewInputProtocol)
    func viewDidLoad()
    func didTapCell(at indexPath: IndexPath)
}

final class CourseListViewController: UIViewController {
    
    var presenter: CourseListPresenter!
    
    // MARK: - Private Properties
    private let cellID = "course"
    private let configurator: CourseListConfiguratorInputProtocol = CourseListConfigurator()
    private var sectionViewModel: CourseSectionViewModelProtocol = CourseSectionViewModel()
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
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
        sectionViewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = sectionViewModel.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let cell = cell as? CourseCell else { return UITableViewCell() }
        cell.viewModel = cellViewModel
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CourseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        sectionViewModel.rows[indexPath.row].cellHeight
    }
}

// MARK: - CourseListViewinputProtocol
extension CourseListViewController: CourseListViewInputProtocol {
    func reloadData(for section: CourseSectionViewModel) {
        sectionViewModel = section
        tableView.reloadData()
    }
}
