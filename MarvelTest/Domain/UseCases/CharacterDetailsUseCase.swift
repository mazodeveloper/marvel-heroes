//
//  CharacterDetailsUseCase.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import Foundation

protocol CharacterDetailsUseCaseContract {
    func execute(id: Int, completion: @escaping (Result<Character, Error>) -> Void)
}

final class CharacterDetailsUseCase: CharacterDetailsUseCaseContract {
    private let provider: CharacterDetailsProviderContract

    init(provider: CharacterDetailsProviderContract) {
        self.provider = provider
    }

    func execute(id: Int, completion: @escaping (Result<Character, Error>) -> Void) {
        provider.fetchCharacterDetails(by: id, completion: completion)
    }
}
