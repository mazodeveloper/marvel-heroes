//
//  MockCharacterDetailsViewContract.swift
//  MarvelTestTests
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import Foundation
@testable import MarvelTest

final class MockCharacterDetailsViewContract: CharacterDetailsContract.View {

    let completion: (Result<CharacterViewModel, Error>) -> Void

    init(completion: @escaping (Result<CharacterViewModel, Error>) -> Void) {
        self.completion = completion
    }

    func render(state: CharacterDetailsViewState) {
        switch state {
        case .failure(let error):
            completion(.failure(error))
        case .success(let character):
            completion(.success(character))
        default:
            break
        }
    }
}
