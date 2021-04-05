//
//  Endpoint.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 30/03/21.
//

import Foundation

enum Endpoint {
    case characters(page: Int)
    case character(id: String)
}

protocol PathGenerable {
    func generatePath(for endpoint: Endpoint) -> String
    func getQueryParameters() -> [String: String]
}

struct MarvelEndpoint: PathGenerable {
    private let baseUrl = "https://gateway.marvel.com"
    private let characters = "/v1/public/characters"
    private let privateKey = ""
    private let publicKey = ""
    private let limit = 50

    func generatePath(for endpoint: Endpoint) -> String {
        var path = baseUrl

        switch endpoint {
        case .characters(let page):
            let offset = page * limit
            path.append("\(characters)?&offset=\(offset)")
        case .character(let id):
            path.append("\(characters)/\(id)?")
        }

        return path
    }

    func getQueryParameters() -> [String: String] {
        let ts = String(Date().timeIntervalSince1970)
        return [
            "ts" : ts,
            "hash" : MD5().generateMD5(info: ts + privateKey + publicKey).lowercased(),
            "apikey" : publicKey,
            "limit" : "\(limit)"
        ]
    }
}
