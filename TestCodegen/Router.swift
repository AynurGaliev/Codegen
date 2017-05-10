//
//  Router.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 6.мая.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation
import Alamofire

enum Router {
    
    static var baseURL: URL = URL(string: "https://hh.ru")!
    
    enum Auth: RequestBuilder {
        
        case authorize(String)
        
        var url: URL {
            switch self {
            case .authorize(_) : return Router.baseURL.appendingPathComponent("oauth/authorize")
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .authorize(_) : return .get
            }
        }
        
        var params: [String : Any] {
            switch self {
            case .authorize(let id) : return ["response_type": "code", "client_id" : id]
            }
        }
        
        var headers: [String : String] {
            switch self {
            case .authorize(_) : return [:]
            }
        }
        
        var encoding: ParameterEncoding {
            switch self {
            case .authorize(_) : return JSONEncoding.default
            }
        }
    }
}

protocol RequestBuilder {
    var method: HTTPMethod { get }
    var params: [String : Any] { get }
    var headers: [String : String] { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
}
