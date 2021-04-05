//
//  CharacterEntity.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 30/03/21.
//

import Foundation

struct CharacterEntity: Codable {
    var id: Int
    var name: String?
    var description: String?
    var thumbnail: ThumbnailEntity?

    func toDomain() throws -> Character {
        
    }
}

struct ThumbnailEntity: Codable {
    var path: String?
    var ext: String?

    enum CodingKeys: String, CodingKey {
        case ext = "extension"
        case path
    }
}
