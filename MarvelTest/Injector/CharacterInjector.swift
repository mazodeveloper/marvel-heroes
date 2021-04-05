//
//  CharacterInjector.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 30/03/21.
//

import Foundation

final class CharacterInjector {
    static func provideCharactersUseCase() -> CharactersUseCaseContract {
        return CharactersUseCase(provider: CharactersProvider())
    }

    static func provideCharacterDetailsUseCase() -> CharacterDetailsUseCaseContract {
        return CharacterDetailsUseCase(provider: CharacterDetailsProvider())
    }
}
