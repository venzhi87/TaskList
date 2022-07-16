//
//  TaskListViewController.swift
//  TaskList
//
//  Created by Pavel Kuzovlev on 30.06.2022.
//

import UIKit
import CoreData

protocol TaskListViewControllerDelegate {
    func reloadData()
}

class TaskListViewController: UITableViewController {
    
    private var viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var taskList: [Task] = []
    private let cellID = "task"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        view.backgroundColor = #colorLiteral(red: 0.7223208547, green: 0.7656075358, blue: 1, alpha: 1)
        setupNavigationBar()
        fetchData()
    }
    
    private func setupNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = #colorLiteral(red: 0.5664296746, green: 0.8364197016, blue: 1, alpha: 1)
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        let navBarAppearanceScroll = UINavigationBarAppearance()
        navBarAppearanceScroll.backgroundColor = #colorLiteral(red: 0.9258603454, green: 1, blue: 0.793887794, alpha: 1)
        navBarAppearanceScroll.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        
        
        navigationController?.navigationBar.standardAppearance = navBarAppearanceScroll
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )
        navigationController?.navigationBar.tintColor = .systemRed
    }
    
    @objc private func addNewTask() {
        
        let taskVC = TaskViewController()
        taskVC.delegate = self
        present(taskVC, animated: true)
    }
    
    private func fetchData() {
        let fetchRequest = Task.fetchRequest()
        do {
            taskList = try viewContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension TaskListViewController: TaskListViewControllerDelegate {
    func reloadData() {
        fetchData()
        tableView.reloadData()
    }
}

extension TaskListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let task = taskList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        cell.contentConfiguration = content
        return cell
    }
}
