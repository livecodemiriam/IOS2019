//
//  CommentsViewController.swift
//  RequestsDemo
//
//  Created by Cristian Olteanu on 13/03/2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var postTitle: UILabel!
    var post: Post!
    var comments: [Comment] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        postTitle.text = post.title
        
        Requests.getComments(postId: post.id,
                             completionHandler: { data, response, error in
                                self.comments = try! JSONDecoder().decode([Comment].self, from: data!)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
        })
    }

    @IBAction func seeAuthor() {
        let userViewController = storyboard?.instantiateViewController(withIdentifier: "user") as! UserViewController
        userViewController.userId = post.userId

        navigationController?.pushViewController(userViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)

        cell.textLabel?.text = comment.name
        cell.detailTextLabel?.text = comment.body

        return cell
    }
}
