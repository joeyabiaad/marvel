//
//  Error.swift
//  Marvel
//
//  Created by Joey Abi Aad on 26/09/2023.
//

import Foundation

struct ErrorModel: Decodable {
    var errors: String
    var errorCode: Int
}
