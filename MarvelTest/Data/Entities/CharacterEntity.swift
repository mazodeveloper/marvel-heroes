//
//  CharacterEntity.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 30/03/21.
//

import Foundation

struct CharacterDataEntity: Codable {
    var data: CharacterResultEntity

    func toDomain() throws -> [Character] {
        try data.toDomain()
    }
}

struct CharacterResultEntity: Codable {
    var results: [CharacterEntity]

    func toDomain() throws -> [Character] {
        try results.compactMap { try $0.toDomain() }
    }
}

struct CharacterEntity: Codable {
    var id: Int
    var name: String?
    var description: String?
    var thumbnail: ThumbnailEntity

    func toDomain() throws -> Character {
        Character(id: id,
                  name: name,
                  description: description,
                  thumbnailURL: URL(string: thumbnail.url))
    }
}
