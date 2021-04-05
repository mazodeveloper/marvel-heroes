//
//  NetworkingError.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 30/03/21.
//

import Foundation

enum NetworkingError: Error, LocalizedError {
    case notFound
    case server
    case decode
    case unauthorized
    case forbidden

    var errorDescription: String? {
        switch self {
        case .notFound:
            return NSLocalizedString("There was an error, couldn't find the requested resource",
                                     comment: "Not Found")
        case .server:
            return NSLocalizedString("There was an error on the server",
                                     comment: "Server error")
        case .decode:
            return NSLocalizedString("There was an error trying to decode the data comes from the server to the app object.",
                                     comment: "Decode error")
        case .unauthorized:
            return NSLocalizedString("Invalid authentication credentials",
                                     comment: "unauthorized error")
        case .forbidden:
            return NSLocalizedString("Insufficient rights to a resource",
                                     comment: "Resource forbidden")
        }
    }
}
