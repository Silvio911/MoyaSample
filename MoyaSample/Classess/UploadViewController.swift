//
//  UploadViewController.swift
//  MoyaSample
//
//  Created by Silvio Bulla on 02/11/2018.
//  Copyright © 2018 Silvio Bulla. All rights reserved.
//

import UIKit
import Moya

class UploadViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!

    let provider = MoyaProvider<Imgur>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView(){
        self.title = "UPLOAD"
        
        uploadButton.addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func uploadImage() {
        uploadButton.isEnabled = false
        guard let imageData  = self.image.image else {return}
        provider.request(.upload(imageData)) { (result) in
            switch result {
            case .success(let response):
                print(response)
                self.uploadButton.isEnabled = true

                let alert = UIAlertController(title: "Success", message: "Image uploaded successfully", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.navigationController?.present(alert, animated: true, completion: nil)
            case .failure(let error):
                print(error)
                self.uploadButton.isEnabled = true

                let alert = UIAlertController(title: "Error", message: "Uploading your image failed", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.navigationController?.present(alert, animated: true, completion: nil)
            }
        }
        
    }

    
    
}
