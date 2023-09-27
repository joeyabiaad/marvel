//
//  TestService.swift
//  Marvel
//
//  Created by Joey Abi Aad on 26/09/2023.
//

import Foundation
import Moya

enum CharactersService {
    static private let publicKey = "20379c29097e71e02e92586b825f04d0"
    static private let privateKey = "e95d2d869b30345d50a639f2f90c3c273a60f7e4"
    
    case getCharacters
    case getCharactersComics(characterId: Int)
}

// MARK: - TargetType Protocol Implementation

extension CharactersService: TargetType {
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var baseURL: URL {
        return URL(string: "https://gateway.marvel.com/v1/public/characters")!
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return ""
        case .getCharactersComics(let characterId):
            return "\(characterId)/comics"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCharacters, .getCharactersComics:
            return .get
        }
    }
    
    var param: [String: Any] {
        switch self {
        case .getCharacters, .getCharactersComics:
            return [:]
        }
    }
    
    var task: Task {
        switch self {
        case .getCharacters, .getCharactersComics:
            let timestamp = String(Date().timeIntervalSince1970)
            let hash = "\(timestamp)\(CharactersService.privateKey)\(CharactersService.publicKey)".md5
            let authParameters: [String: Any] = [
                "apikey": CharactersService.publicKey,
                "ts": timestamp,
                "hash": hash
            ]
            return .requestParameters(parameters: authParameters, encoding: URLEncoding.default)
        }
    }
}

// MARK: - Extension

extension Encodable {
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
