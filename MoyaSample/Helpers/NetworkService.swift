//
//  NetworkService.swift
//  MoyaSample
//
//  Created by Silvio Bulla on 18/10/2018.
//  Copyright © 2018 Silvio Bulla. All rights reserved.
//

import Foundation
import Moya

enum NetworkService {
    case posts
    case createPost(id:Int, userId:Int, title: String, body:String)
    case deletePost(id: Int)
}

extension NetworkService: TargetType {
    
    public var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    public var path: String {
        switch self {
        case .posts, .createPost(_ ,_ ,_ ,_):
            return "/posts"
        case .deletePost(let id):
            return "posts/\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .posts:
            return .get
        case .createPost(_ ,_ ,_ ,_):
            return .post
        case .deletePost(_):
            return .delete
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .posts:
            return .requestPlain
        case .createPost(let id, let userId, let title, let body):
            return .requestParameters(parameters: ["id": id, "userId": userId, "title": title, "body": body], encoding: JSONEncoding.default)
        case .deletePost(let id):
            return .requestParameters(parameters: ["id":id], encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
}
