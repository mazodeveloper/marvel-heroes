//
//  CharacterDetailsProvider.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import Foundation

final class CharacterDetailsProvider: CharacterDetailsProviderContract {

    let baseService: BaseService

    init(baseService: BaseService = WebService()) {
        self.baseService = baseService
    }

    func fetchCharacterDetails(by id: Int,
                               completion: @escaping (Result<Character, Error>) -> Void) {
        baseService.execute(endpoint: .character(id: "\(id)")) { (response: Result<CharacterDataEntity, Error>) in
            switch response {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let characters = try? data.toDomain(),
                      let character = characters.first else {
                    completion(.failure(ProviderError.parse))
                    return
                }
                completion(.success(character))
            }
        }
    }
}
