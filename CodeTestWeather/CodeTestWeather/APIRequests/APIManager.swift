//
//  APIManager.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation
import Alamofire

typealias ResultHandler<T> = (ResultResponse<T>) -> Void

enum ResultResponse<Value> {
    
    case success(Value)
    case failure(ResponseError?)
}

struct ResponseError {
    let errorCode: Int
    let errorMessage: String
}
class APIManager {
    
    private static var sharedApiManager: APIManager = {
        let apiManager = APIManager()
        
        return apiManager
    }()
    
    class func shared() -> APIManager {
        return sharedApiManager
    }
    

    func request<T>(type: EndPointType, handler: @escaping ResultHandler<T>) where T: Codable {
        
        Alamofire.request(type.url, method: type.httpMethod , parameters: type.params, encoding: type.encoding, headers: type.headers).validate().responseJSON { [weak self] (response) in
            
            guard let _ = self else {
                return
            }
            
            if response.result.isSuccess {
                let decoder = JSONDecoder()
                if let data = response.data {
                    if let jsonReslut = try? decoder.decode(T.self, from: data) {
                        handler(.success(jsonReslut))
                    }else{
                        let error = ResponseError(errorCode: 999, errorMessage: FailureError.jsonEncodingFailed.rawValue)
                        handler(.failure(error))
                    }
                }else{
                    let error = ResponseError(errorCode: 999, errorMessage: FailureError.emptyData.rawValue)
                    handler(.failure(error))
                }
            }
            else{
                let error = ResponseError(errorCode: response.response?.statusCode ?? 999, errorMessage: response.error?.localizedDescription ?? "")
                handler(.failure(error))
            }
        }
        
        
    }
}
