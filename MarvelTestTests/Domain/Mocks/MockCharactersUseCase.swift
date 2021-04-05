//
//  MockCharactersUseCase.swift
//  MarvelTestTests
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import Foundation
@testable import MarvelTest

final class MockCharactersUseCase: CharactersUseCaseContract {

    let result: Result<[Character], Error>

    init(result: Result<[Character], Error>) {
        self.result = result
    }

    func execute(page:Int, completion: @escaping (Result<[Character], Error>) -> Void) {
        completion(result)
    }
}
