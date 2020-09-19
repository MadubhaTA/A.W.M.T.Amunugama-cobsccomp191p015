//
//  LoginResponse.swift
//  A.W.M.T.Amunugama-cobsccomp191p015
//
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class LoginResponse: APIModel {
    
    var token:String?
    var user:User?
   
    override func mapping(map: Map) {
        token <- map["token"]
        user <- map["user"]
        message <- map["message"]
    }

}
