//
//  Imgur.swift
//  MoyaSample
//
//  Created by Silvio Bulla on 02/11/2018.
//  Copyright © 2018 Silvio Bulla. All rights reserved.
//

import Foundation
import Moya

public enum Imgur {
    
    static private let clientId = "f1770fbd5e55b1e"
    //e54c7161fa70d17f6e0b466d24deb6e852f1b6f2
    
    case upload(UIImage)
}

extension Imgur: TargetType {
    
    public var baseURL: URL {
        return URL(string: "https://api.imgur.com/3")!
    }
    
    public var path: String {
        return "/image"
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .upload(let image):
            let imageData = UIImageJPEGRepresentation(image, 1.0)!
            return .uploadMultipart([MultipartFormData(provider: .data(imageData), name: "image", fileName: "moyaSample.jpg", mimeType: "image/jpg")])
        }
    }
    
    public var headers: [String: String]? {
        return [
            "Authorization": "Client-ID \(Imgur.clientId)",
            "Content-Type": "application/json"
        ]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
}
