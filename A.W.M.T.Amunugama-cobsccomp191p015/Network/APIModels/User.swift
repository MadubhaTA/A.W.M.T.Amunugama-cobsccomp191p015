//
//  User.swift
//  A.W.M.T.Amunugama-cobsccomp191p015
//
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class User: APIModel {
    
    var userId:String?
    var name:String?
    var email:String?
    
    override func mapping(map: Map) {
        userId <- map["uid"]
        name <- map["displayName"]
        email <- map["email"]
    }
}
