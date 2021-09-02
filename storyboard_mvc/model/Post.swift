//
//  Post.swift
//  storyboard_mvc
//
//  Created by User on 2021/04/22.
//

import Foundation

struct Post: Decodable{
    var id: String? = ""
    var title: String? = ""
    var body: String? = ""

    
    init(title: String,body: String) {
        self.title = title
        self.body = body
    }
}
