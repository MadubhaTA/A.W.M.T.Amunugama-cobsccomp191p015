//
//  APIModel.swift
//  A.W.M.T.Amunugama-cobsccomp191p015
//
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class APIModel: Mappable {
    
    var message:String?
    var responserError: ResponseError?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
    }
    

}
