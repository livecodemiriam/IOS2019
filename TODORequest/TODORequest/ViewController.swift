//
//  ViewController.swift
//  TODORequest
//
//  Created by Miriam Costan on 27/03/2019.
//  Copyright © 2019 Miriam Costan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var todos: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTODOs(userId: 1)
    }
    
    func getTODOs(userId: Int) {
        let urlSession = URLSession(configuration: .default)
        var urlComponents = URLComponents(string: "https://jsonplaceholder.typicode.com/todos")
        urlComponents?.query = "userId=\(userId)"
        
        let url = urlComponents?.url
        
        let dataTask = urlSession.dataTask(with: url!,
                                           completionHandler: { (data, response, error) in
                                            let decoder = JSONDecoder()
                                            self.todos = try! decoder.decode([Todo].self, from: data!)
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
        })
        dataTask.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = todos[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = todo.title
        if todo.completed {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryView = .none
        }
        return cell
    }
    
}

