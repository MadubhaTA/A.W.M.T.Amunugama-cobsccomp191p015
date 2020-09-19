//
//  TempAllResponse.swift
//  A.W.M.T.Amunugama-cobsccomp191p015
//
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class TempAllResponse: APIModel {
    
   var locId:String?
    var temp:Temp?
    
     override func mapping(map: Map) {
        locId <- map["id"]
        temp <- map["data"]
     }

}
