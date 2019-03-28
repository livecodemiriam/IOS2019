//
//  ViewController.swift
//  RequestsDemo
//
//  Created by Cristian Olteanu on 13/03/2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        Requests.getPosts(completionHandler: { data, response, error in
            self.posts = try! JSONDecoder().decode([Post].self, from: data!)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "post") as! PostTableViewCell
        cell.titleLabel.text = post.title
        cell.bodyLabel.text = post.body
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = posts[indexPath.row]

        let commentsViewController = storyboard?.instantiateViewController(withIdentifier: "comments") as! CommentsViewController

        commentsViewController.post = post

        navigationController?.pushViewController(commentsViewController, animated: true)
    }
}

