//
//  CharactersUseCase.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 30/03/21.
//

import Foundation

protocol CharactersUseCaseContract {
    func execute(page: Int, completion: @escaping (Result<[Character], Error>) -> Void)
}

final class CharactersUseCase: CharactersUseCaseContract {

    private let provider: CharactersProviderContract

    init(provider: CharactersProviderContract) {
        self.provider = provider
    }

    func execute(page: Int, completion: @escaping (Result<[Character], Error>) -> Void) {
        provider.fetchCharacters(page: page, completion: completion)
    }
}
