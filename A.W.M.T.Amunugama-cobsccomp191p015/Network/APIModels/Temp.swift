//
//  Temp.swift
//  A.W.M.T.Amunugama-cobsccomp191p015
//
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class Temp: APIModel {
    
    var long:String?
    var lat:String?
    var name:String?
    var temparature:String?
    
    override func mapping(map: Map) {
        long <- map["long"]
        lat <- map["lat"]
        temparature <- map["temp"]
        name <- map["displayName"]
    }
}
