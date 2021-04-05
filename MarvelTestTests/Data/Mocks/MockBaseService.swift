//
//  MockBaseService.swift
//  MarvelTestTests
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import Foundation
@testable import MarvelTest

final class MockBaseService: BaseService {
    let result: Result<Data, Error>

    init(result: Result<Data, Error>) {
        self.result = result
    }

    func execute<Output>(endpoint: Endpoint,
                         completion: @escaping (Result<Output, Error>) -> Void) where Output : Decodable {
        switch result {
        case .success(let data):
            do {
                let dataModel = try JSONDecoder().decode(Output.self, from: data)
                completion(.success(dataModel))
            } catch {
                completion(.failure(error))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
