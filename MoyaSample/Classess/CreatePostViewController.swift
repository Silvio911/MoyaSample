//
//  CreatePostViewController.swift
//  MoyaSample
//
//  Created by Silvio Bulla on 23/10/2018.
//  Copyright © 2018 Silvio Bulla. All rights reserved.
//

import UIKit
import Moya

class CreatePostViewController: UIViewController {
   
    let provider = MoyaProvider<NetworkService>()
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    var addButtonItem = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Post"
        
        addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewPost))
        navigationItem.rightBarButtonItem = addButtonItem
    }
    
    //MARK:- POST.

    @objc func createNewPost(){
        addButtonItem.isEnabled = false
        var postCreated = Post()
        postCreated.id = 101
        postCreated.userId = 101
        postCreated.title = titleTextField.text ?? ""
        postCreated.body = bodyTextField.text ?? ""
    
        provider.request(.createPost(id: postCreated.id, userId: postCreated.userId, title: postCreated.title, body: postCreated.body)) { (result) in
            switch result {
            case .success(let response):
                let newPost = try! JSONDecoder().decode(Post.self, from: response.data)
                print(newPost)
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "GetPostsViewController") as! GetPostsViewController
                vc.dataArray.insert(newPost, at: 0)
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                print(error)
            }
            self.addButtonItem.isEnabled = true
        }
    }
    
}
