//
//  HelperModels.swift
//  Marvel
//
//  Created by Joey Abi Aad on 26/09/2023.
//

import UIKit

enum HttpStatus: Int {
    case success = 200
    case created = 201
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case conflict = 409
    case serverError = 500
    case none
    
    var success: Bool {
        switch self {
        case .success, .created:
            return true
        case .badRequest, .unauthorized, .forbidden, .notFound, .serverError, .none, .conflict:
            return false
        }
    }
    var title: String{
        switch self {
        case .success:
            return "Success"
        case .created:
            return "Created"
        case .badRequest:
            return "Bad Request"
        case .unauthorized:
            return "Unauthorized"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Not Found"
        case .serverError:
            return "Server Error"
        case .conflict:
            return "Conflict"
        case .none:
            return "Error"
        }
    }
}

enum SharedKeys: String {
    /// Raw value should not be changed if the app is live
    
    /// Saved variables
    case isLogging = "isLogging"
    case userInterfaceStyle = "userInterfaceStyle"
    case didChooseUserInterface = "didChooseUserInterface"
    case currentDeviceId = "currentDeviceId"
    case addressSecurity = "addressSecurity"
    case didChooseBiometricState = "didChooseBiometricState"
    case encryptionKey = "encryptionKey"
    case encryptionIv = "encryptionIV"
    case shouldShowOnboarding = "shouldShowOnboarding"
    case shouldShowChooseNickname = "shouldShowChooseNickname"
    case fontSize = "fontSize"
}

enum Month: Int {
    case jan = 1
    case feb = 2
    case mar = 3
    case apr = 4
    case may = 5
    case jun = 6
    case jul = 7
    case aug = 8
    case sep = 9
    case oct = 10
    case nov = 11
    case dec = 12
    

    var days: [Int] {
        switch self {
        case .jan, .mar, .may, .jul, .aug, .oct, .dec:
            return Array(1...31)
        case .apr, .jun, .sep, .nov:
            return Array(1...30)
        case .feb:
            return Array(1...29)
        }
    }
}
