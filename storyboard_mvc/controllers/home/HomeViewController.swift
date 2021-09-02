import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, HomeView {

    @IBOutlet weak var tableView: UITableView!
    var items : Array<Post> = Array()
    var presenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    func reloadTableView(posts: [Post]){
        self.items =  posts
        self.tableView.reloadData()
    }
    
    func onLoadPosts(posts: [Post]) {
        if posts.count > 0 {
            reloadTableView(posts: posts)
        }else{
            // error case
        }
    }
    
    func onPostDeleted(deleted: Bool) {
        if deleted {
            presenter.apiPostList()
        }else{
            // error case
        }
    }


    // MARK: - Method
    
    func initViews(){
        tableView.dataSource = self
        tableView.delegate = self
        initNavigation()
        
        presenter = HomePresenter()
        presenter.homeView = self
        presenter.controller = self
        
        presenter.apiPostList()
    }
    
    func initNavigation(){
        let refresh = UIImage(named: "ic_refresh")
        let add = UIImage(named: "ic_add")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "MVP Pattern"
    }

    func callCreateViewController(){
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callEditViewController(){
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - Action
    
    @objc func leftTapped(){
        presenter.apiPostList()
    }
    
    @objc func rightTapped(){
        callCreateViewController()
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("PostTableViewCell", owner: self, options: nil)?.first as! PostTableViewCell
        
        cell.titleLabel.text = item.title
        cell.bodyLabel.text = item.body
        
        return cell
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeCompleteContextualAction(forRowAt: indexPath, post: items[indexPath.row])
        ])
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath, post: items[indexPath.row])
        ])
    }
    
    //MARK: - Contextual Actions
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath, post: Post) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            print("DELETE HERE")

            completion(true)
            self.presenter.apiPostDelete(post: post)
        }
    }

    private func makeCompleteContextualAction(forRowAt indexPath: IndexPath, post: Post) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            print("COMPLETE HERE")
            completion(true)
            self.callEditViewController()
        }
    }
}
