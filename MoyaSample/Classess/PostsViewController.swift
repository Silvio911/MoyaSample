//
//  PostsViewController.swift
//  MoyaSample
//
//  Created by Silvio Bulla on 18/10/2018.
//  Copyright © 2018 Silvio Bulla. All rights reserved.
//

import UIKit
import Moya

enum State {
    case success
    case loading
    case error
}

class PostsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let provider = MoyaProvider<NetworkService>()
    
    var dataArray: [Post] = []
    
    var viewState = State.success
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getPosts()
    }
    
    func setupView(){
        self.title = "GET"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func getPosts(){
        provider.request(.posts) { result in
            self.viewState = .loading
            switch result {
            case .success(let response):
                do {
                    let data = try response.mapJSON()
                    let json = try JSONSerialization.data(withJSONObject: data)
                    let decodedPosts = try JSONDecoder().decode([Post].self, from: json)
                    decodedPosts.forEach{print($0)}
                    
                    self.dataArray = decodedPosts
                    self.viewState = .success
                } catch {
                    print(error)
                    self.viewState = .error
                }
            case .failure(let error):
                print(error)
                self.viewState = .error
            }
            self.tableView.reloadData()
        }
    }

}

extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128.0
    }
    
}

extension PostsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard viewState == .success else { return 1 }
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        guard viewState == .success else {
            if viewState == .loading {
                cell.textLabel?.text = "Loading..."
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            }else{
                cell.textLabel?.text = "Error"
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            }
            return cell
        }
        let model = dataArray[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(model.id). \(model.title)"
        cell.detailTextLabel?.text = model.body
        return cell
    }
    
}
