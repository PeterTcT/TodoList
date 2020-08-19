//
//  ViewController.swift
//  TodoList035
//
//  Created by COTEMIG on 19/08/20.
//  Copyright © 2020 Cotemig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var todoList: UITableView!
    let taskKey = "tasksList"
    var taskList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        todoList.dataSource = self
        if let receviedList =  UserDefaults.standard.value(forKey: taskKey) as? [String]{
            taskList.append(contentsOf: receviedList)
        }
    }

    @IBAction func addTodo(_ sender: Any) {
        
        let alert = UIAlertController(title: "Adicione tarefa", message: "Adicione uma nova tarefa a sua lista", preferredStyle: .alert)
        
        let saveAaction = UIAlertAction(title: "Salvar", style: .default) { (action) in
            if let textField = alert.textFields?.first, let text = textField.text{
                self.taskList.append(text)
                self.todoList.reloadData()
                UserDefaults.standard.set(self.taskList, forKey: self.taskKey)
            }
        }
        
        let cancelAaction = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alert.addAction(saveAaction)
        alert.addAction(cancelAaction)
        alert.addTextField()
    
        
        //apenas viewcontrollers podem mostrar outras viewcontrollers
        present(alert, animated: true)
    }
    
}


extension ViewController: UITableViewDataSource{
    //num de celulas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    //create cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoList.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = taskList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle:UITableViewCell.EditingStyle, forRowAt indexPath:IndexPath){
        if editingStyle == .delete{
            taskList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(self.taskList, forKey: self.taskKey)
            
        }
    }
    
    
}
