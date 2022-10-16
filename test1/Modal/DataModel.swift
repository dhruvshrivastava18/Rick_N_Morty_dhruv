//
//  DataModel.swift
//  test1
//
//  Created by Dhruv Shrivastava on 14/09/22.
//

import Foundation

struct CharacterDataModel: Codable{
    var info: CharacterInfo
    var results: [CharacterModel]
}

struct CharacterModel: Codable{
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: CharacterOrigin
    var location: CharacterLocation
    var image: String
    var episode: [String]
    var url: String
    var created: String
}


struct CharacterInfo: Codable{
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}

struct CharacterOrigin: Codable{
    var name: String
    var url: String
}

struct CharacterLocation: Codable{
    var name: String
    var url: String
}
