//
//  Endpoint.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation
import Alamofire

protocol EndPointType {
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    var query: String { get }
    var params: [String: Any]? { get }
}
extension EndPointType {
    
    var baseURL: String {
        return Constants.baseUrl
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
    
    var url: URL {
        return URL(string: self.baseURL + self.path + self.query)!
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
}
