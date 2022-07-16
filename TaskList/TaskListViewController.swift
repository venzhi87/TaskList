//
//  TaskListViewController.swift
//  TaskList
//
//  Created by Pavel Kuzovlev on 30.06.2022.
//

import UIKit
import CoreData

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
        showAlert(with: "New Task", and: "What do you whant to do?")
    }
    
    private func fetchData() {
        let fetchRequest = Task.fetchRequest()
        do {
            taskList = try viewContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func showAlert(with title: String, and massage: String) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
            self.save(task)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.placeholder = "New Task"
        }
        present(alert, animated: true)
    }

    
    private func save(_ taskName: String) {
        let task = Task(context: viewContext)
        task.title = taskName
        taskList.append(task)
        
        let cellIndex = IndexPath(row: taskList.count - 1, section: 0)
        tableView.insertRows(at: [cellIndex], with: .automatic)
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
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
