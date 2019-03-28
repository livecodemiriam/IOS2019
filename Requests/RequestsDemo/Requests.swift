//
//  Requests.swift
//  RequestsDemo
//
//  Created by Cristian Olteanu on 13/03/2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

class Requests {
    static func getPosts(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let urlSession = URLSession(configuration: .default)

        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")

        let dataTask = urlSession.dataTask(with: url!,
                                           completionHandler: completionHandler)

        dataTask.resume()
    }
    static func getComments(postId: Int,
                            completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let urlSession = URLSession(configuration: .default)
        
        var urlComponents = URLComponents(string: "https://jsonplaceholder.typicode.com/comments")
        urlComponents?.query = "postId=\(postId)"
        
        let url = urlComponents?.url
        
        let dataTask = urlSession.dataTask(with: url!,
                                           completionHandler: completionHandler)
        
        dataTask.resume()
    }
    static func getUser(userId: Int,
                            completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let urlSession = URLSession(configuration: .default)
        
        var urlComponents = URLComponents(string: "https://jsonplaceholder.typicode.com/users")
        urlComponents?.query = "id=\(userId)"
        
        let url = urlComponents?.url
        
        let dataTask = urlSession.dataTask(with: url!,
                                           completionHandler: completionHandler)
        
        dataTask.resume()
    }
}
