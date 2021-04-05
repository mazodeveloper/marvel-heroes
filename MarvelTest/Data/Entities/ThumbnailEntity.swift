//
//  ThumbnailEntity.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 30/03/21.
//

import Foundation

struct ThumbnailEntity: Codable {
    var path: String?
    var ext: String?

    var url: String {
        guard let path = path,
              let ext = ext else {
            return ""
        }
        return "\(path).\(ext)"
    }

    enum CodingKeys: String, CodingKey {
        case ext = "extension"
        case path
    }
}
