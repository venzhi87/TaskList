//
//  AlertController.swift
//  TaskList
//
//  Created by Pavel Kuzovlev on 08.02.2023.
//

import UIKit

extension UIAlertController {
    
    static func createAlertController(withTitle title: String) -> UIAlertController {
        UIAlertController(title: title, message: "Что Вы хотите сделать?", preferredStyle: .alert)
    }
    
    func action(task: Task?, completion: @escaping (String) -> Void) {
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let newValue = self.textFields?.first?.text else { return }
            guard !newValue.isEmpty else { return }
            completion(newValue)
        }
        
        let cancelAction = UIAlertAction(title: "Выйти", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "Текст"
            textField.text = task?.title
        }
    }
}
