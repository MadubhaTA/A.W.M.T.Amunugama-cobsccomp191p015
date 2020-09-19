//
//  ResponseError.swift
//  A.W.M.T.Amunugama-cobsccomp191p015
//
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class ResponseError: APIModel {
    
    var errorText: String?
    
    override func mapping(map: Map) {
        errorText <- map["text"]
    }

}
