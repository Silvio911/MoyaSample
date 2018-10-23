//
//  Post.swift
//  MoyaSample
//
//  Created by Silvio Bulla on 18/10/2018.
//  Copyright © 2018 Silvio Bulla. All rights reserved.
//

import Foundation

struct Post: Codable{
    
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
    //MARK:- Can use CodableKeys if the var names are not same.
    
    init() {
        userId = 0
        id = 0
        title = ""
        body = ""
    }
    
}
