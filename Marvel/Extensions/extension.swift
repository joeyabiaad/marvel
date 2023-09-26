//
//  extension.swift
//  Marvel
//
//  Created by Elio Chalhoub on 26/09/2023.
//

import Foundation
import CommonCrypto

extension String {
    var md5: String {
        if let data = data(using: .utf8) {
            var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            _ = data.withUnsafeBytes {
                CC_MD5($0.baseAddress, CC_LONG(data.count), &digest)
            }
            return (0..<Int(CC_MD5_DIGEST_LENGTH)).map {
                String(format: "%02x", digest[$0])
            }.joined()
        }
        return ""
    }
}
