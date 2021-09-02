//
//  HomePresenter.swift
//  storyboard_mvc
//
//  Created by User on 2021/04/22.
//

import Foundation
import Alamofire

protocol HomeView {
    func onLoadPosts(posts: [Post])
    
    func onPostDeleted(deleted: Bool)
}
