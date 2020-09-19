//
//  UserTempResponse.swift
//  A.W.M.T.Amunugama-cobsccomp191p015
//
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class UserTempResponse: APIModel {
    
     var temp:Temp?
    
     override func mapping(map: Map) {
         temp <- map["item"]
     }
}
