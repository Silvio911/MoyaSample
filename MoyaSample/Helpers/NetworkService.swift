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
}

extension NetworkService: TargetType {
    
    public var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    public var path: String {
        switch self {
        case .posts :
            return "/posts"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .posts:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        //MARK:- If request has parametrs(multipart etc...) add those here.
        //return .requestParameters(parameters: ["name": name], encoding: JSONEncoding.default)
        
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
}
