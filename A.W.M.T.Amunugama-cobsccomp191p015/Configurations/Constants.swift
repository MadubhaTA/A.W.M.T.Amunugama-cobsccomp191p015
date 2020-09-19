//
//  Constants.swift
//  A.W.M.T.Amunugama-cobsccomp191p015
//
//

import Foundation

struct Constants {
    static let baseUrl = "https://us-central1-covid-1c5a7.cloudfunctions.net/"
}

struct APIRequestMetod {
    static let login = "api/login"
    static let signup = "api/signup"
    static let getUserTemp = "api/location/read"
    static let createUserTemp = "api/location/create"
    static let updateUserTemp = "api/location/update"
    static let getAllTemp = "api/location/read/all"
}

struct APIRequestKeys {
    static let email = "email"
    static let password = "password"
    static let name = "displayName"
    static let phone = "phoneNumber"
    static let role = "role"
    static let lat = "lat"
    static let long = "long"
    static let temp = "temp"
    static let data = "data"
}
