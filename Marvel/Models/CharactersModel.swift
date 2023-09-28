//
//  CharactersModel.swift
//  Marvel
//
//  Created by Joey Abi Aad on 26/09/2023.
//

import Foundation

struct CharactersModel: Decodable, Encodable {
    var data: Dataa?
}

struct Dataa: Decodable, Encodable {
    var offset: Int
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [Result]?
}

struct Result: Decodable, Encodable {
    var id: Int?
    var name: String?
    var description: String?
    var modified: String?
    var thumbnail: Thumbnail?
    var resourceURI: String?
    var comics: Details?
    var returned: Int?
    var series: Details?
    var stories: Details?
    var events: Details?
}

struct Thumbnail: Decodable, Encodable {
    var path: String?
    var `extension`: String?
}

struct Details: Decodable, Encodable {
    var available: Int?
    var collectionURI: String?
    var items: [Item]?
}

struct Item: Decodable, Encodable {
    var resourceURI: String?
    var name: String?
}
