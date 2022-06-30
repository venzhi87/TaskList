//
//  TaskListViewController.swift
//  TaskList
//
//  Created by Pavel Kuzovlev on 30.06.2022.
//

import UIKit

class TaskListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.7223208547, green: 0.7656075358, blue: 1, alpha: 1)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Task List"
        //        navigationController?.navigationBar.backgroundColor = .systemBlue
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
        present(taskVC, animated: true)

        
    }
     
}

