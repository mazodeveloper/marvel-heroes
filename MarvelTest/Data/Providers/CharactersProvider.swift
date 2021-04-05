//
//  CharactersProvider.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 30/03/21.
//

import Foundation

final class CharactersProvider: CharactersProviderContract {

    let baseService: BaseService

    init(baseService: BaseService = WebService()) {
        self.baseService = baseService
    }

    func fetchCharacters(page: Int, completion: @escaping (Result<[Character], Error>) -> Void) {
        baseService.execute(endpoint: .characters(page: page)) { (response: Result<CharacterDataEntity, Error>) in
            switch response {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let characters = try? data.toDomain() else {
                    completion(.failure(ProviderError.parse))
                    return
                }
                completion(.success(characters))
            }
        }
    }
}
