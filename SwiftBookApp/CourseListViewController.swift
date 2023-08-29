//
//  CourseListTableViewController.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 8/29/23.
//

import UIKit

class CourseListViewController: UITableViewController {
    
    private let cellID = "course"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }

}

// MARK: - UITableViewDataSource
extension CourseListViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
     
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
         
         return cell
     }
}

// MARK: - UITableViewDelegate
extension CourseListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(CourseDetailsViewController(), animated: true)
    }
}
