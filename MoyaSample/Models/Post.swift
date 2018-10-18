//
//  Post.swift
//  MoyaSample
//
//  Created by Silvio Bulla on 18/10/2018.
//  Copyright © 2018 Silvio Bulla. All rights reserved.
//

import Foundation

struct Post: Codable{
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    //MARK:- Can use CodableKeys if the var names are not same.
    
    init() {
        userId = 0
        id = 0
        title = ""
        body = ""
    }
    
}
