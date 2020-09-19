//
//  APIClient.swift
//  A.W.M.T.Amunugama-cobsccomp191p015
//
//

import UIKit
import Alamofire
import SwiftyJSON

class APIClient: NSObject {
    
    enum APIResponseStatus : Int {
        case Success = 200
        case Failure = -1
        case SuccessAlso = 201
        case ValidationError = 409
        case BadRequest = 400
        case UnAuthorized = 401
        case NotFound = 404
        case InternalServerError = 500
        case NoNetwork
        case Other
    }
    
    static let shared = APIClient()
    
    func getHTTPHeaders() -> HTTPHeaders? {
        return ["Content-Type" : "application/json",
                "Accept": "application/json",
                "Authorization" : "Bearer " + Utilities.token(),
        ]
    }
}

extension APIClient {
    
    func login(email:String, password:String, completion:@escaping (APIResponseStatus, LoginResponse?) -> Void) {
        let params = [APIRequestKeys.email:email, APIRequestKeys.password:password]
        let request = Alamofire.request( Constants.baseUrl + APIRequestMetod.login,
                                  method: .post,
                                  parameters: params as Parameters,
                                  encoding: JSONEncoding.default,
                                  headers: self.getHTTPHeaders())
        request.responseObject {
            (response:DataResponse<LoginResponse>) in
            switch response.result {
            case .success(_):
                completion(APIClient.APIResponseStatus(rawValue: (response.response?.statusCode)!)!, response.value!)
            case .failure(let encodingError):
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    completion(APIClient.APIResponseStatus.NoNetwork, nil)
                } else {
                    completion(APIClient.APIResponseStatus.Other, nil)
                }
            }
            
        }
    }
    
    func signup(email:String,name:String, role:String, password:String,phone:String, completion:@escaping (APIResponseStatus, LoginResponse?) -> Void) {
        let params = [APIRequestKeys.email:email, APIRequestKeys.name:name, APIRequestKeys.role:"admin", APIRequestKeys.phone:phone, APIRequestKeys.password:password]
        let request = Alamofire.request( Constants.baseUrl + APIRequestMetod.signup,
                                  method: .post,
                                  parameters: params as Parameters,
                                  encoding: JSONEncoding.default,
                                  headers: self.getHTTPHeaders())
        request.responseObject {
            (response:DataResponse<LoginResponse>) in
            switch response.result {
            case .success(_):
                completion(APIClient.APIResponseStatus(rawValue: (response.response?.statusCode)!)!, response.value!)
            case .failure(let encodingError):
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    completion(APIClient.APIResponseStatus.NoNetwork, nil)
                } else {
                    completion(APIClient.APIResponseStatus.Other, nil)
                }
            }
            
        }
    }
    
    func createTemp(lat:String,long:String, temp:String, name:String, completion:@escaping (APIResponseStatus, LoginResponse?) -> Void) {
        
        let data:NSMutableDictionary = NSMutableDictionary()
        data.setValue(long, forKey: APIRequestKeys.long)
        data.setValue(lat, forKey: APIRequestKeys.lat)
        data.setValue(name, forKey: APIRequestKeys.name)
        data.setValue(temp, forKey: APIRequestKeys.temp)
        
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: [])
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        print(jsonString)
        print(self.getHTTPHeaders())
        
        let params = [APIRequestKeys.data:data]
        print(params)
        let request = Alamofire.request( Constants.baseUrl + APIRequestMetod.createUserTemp,
                                  method:.post,
                                  parameters: params as Parameters,
                                  encoding: JSONEncoding.default,
                                  headers: self.getHTTPHeaders())
        request.validate()
        request.responseObject {
            (response:DataResponse<LoginResponse>) in
            switch response.result {
            case .success(_):
                print(response.response)
                completion(APIClient.APIResponseStatus(rawValue: (response.response?.statusCode)!)!, response.value!)
            case .failure(let encodingError):
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    completion(APIClient.APIResponseStatus.NoNetwork, nil)
                } else {
                    completion(APIClient.APIResponseStatus.Other, nil)
                }
            }
            
        }
    }
    
    func updateTemp(lat:String,long:String, temp:String, name:String, completion:@escaping (APIResponseStatus, LoginResponse?) -> Void) {
        let data:NSMutableDictionary = NSMutableDictionary()
        data.setValue(long, forKey: APIRequestKeys.long)
        data.setValue(lat, forKey: APIRequestKeys.lat)
        data.setValue(name, forKey: APIRequestKeys.name)
        data.setValue(temp, forKey: APIRequestKeys.temp)
        
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: [])
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        print(jsonString)
        
        let params = [APIRequestKeys.data:data]
        let request = Alamofire.request( Constants.baseUrl + APIRequestMetod.updateUserTemp,
                                  method:.put,
                                  parameters: params as Parameters,
                                  encoding: JSONEncoding.default,
                                  headers: self.getHTTPHeaders())
        request.validate(statusCode: 189...200)
        request.responseObject {
            (response:DataResponse<LoginResponse>) in
            switch response.result {
            case .success(_):
                print(response.response)
                completion(APIClient.APIResponseStatus(rawValue: (response.response?.statusCode)!)!, response.value!)
            case .failure(let encodingError):
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    completion(APIClient.APIResponseStatus.NoNetwork, nil)
                } else {
                    completion(APIClient.APIResponseStatus.Success, nil)
                }
            }
            
        }
    }
    
    func getUserTemp(completion:@escaping (APIResponseStatus, UserTempResponse?) -> Void) {
        let request = Alamofire.request( Constants.baseUrl + APIRequestMetod.getUserTemp,
                                  method: .get,
                                  parameters: nil,
                                  encoding: JSONEncoding.default,
                                  headers: self.getHTTPHeaders())
        request.responseObject {
            (response:DataResponse<UserTempResponse>) in
            switch response.result {
            case .success(_):
                completion(APIClient.APIResponseStatus(rawValue: (response.response?.statusCode)!)!, response.value!)
            case .failure(let encodingError):
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    completion(APIClient.APIResponseStatus.NoNetwork, nil)
                } else {
                    completion(APIClient.APIResponseStatus.Other, nil)
                }
            }
            
        }
    }
    
    func getAllTemp(completion:@escaping (APIResponseStatus, [TempAllResponse]?) -> Void) {
        let request = Alamofire.request( Constants.baseUrl + APIRequestMetod.getAllTemp,
                                  method: .get,
                                  parameters: nil,
                                  encoding: JSONEncoding.default,
                                  headers: self.getHTTPHeaders())
        request.responseArray { (response: DataResponse<[TempAllResponse]>) in
            switch response.result {
            case let .success(value):
                completion(APIClient.APIResponseStatus(rawValue: (response.response?.statusCode)!)!, value)
            case .failure(let encodingError):
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    completion(APIClient.APIResponseStatus.NoNetwork, nil)
                } else {
                    completion(APIClient.APIResponseStatus.Other, nil)
                }
            }
        }
    }
}
