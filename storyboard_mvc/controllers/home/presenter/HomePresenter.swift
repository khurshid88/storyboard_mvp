//
//  HomeView.swift
//  storyboard_mvc
//
//  Created by User on 2021/04/22.
//

import Foundation

protocol HomePresenterProtocol {
    func apiPostList()
    func apiPostDelete(post:Post)
}

class HomePresenter: HomePresenterProtocol {
    var homeView: HomeView!
    var controller: BaseViewController!
    
    func apiPostList() {
        controller?.showProgress()
        
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                let posts = try! JSONDecoder().decode([Post].self, from: response.data!)
                self.homeView.onLoadPosts(posts: posts)
            case let .failure(error):
                print(error)
                self.homeView.onLoadPosts(posts: [Post]())
            }
        })
    }
    
    func apiPostDelete(post: Post) {
        controller?.showProgress()
        
        AFHttp.del(url: AFHttp.API_POST_LIST + post.id!, params: AFHttp.paramsEmpty(), handler: { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                self.homeView.onPostDeleted(deleted: true)
            case let .failure(error):
                self.homeView.onPostDeleted(deleted: false)
                print(error)
            }
        })
    }
    
}
