//
//  CharactersUseCaseTests.swift
//  MarvelTestTests
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import XCTest
@testable import MarvelTest

final class CharactersUseCaseTests: XCTestCase {

    var useCase: CharactersUseCase?

    override func setUp() {
        super.setUp()
        let character = Character(id: 14,
                                  name: "Spider man",
                                  description: "Peter",
                                  thumbnailURL: nil)
        let mockProvider = MockCharactersProvider(result: .success([character]))
        useCase = CharactersUseCase(provider: mockProvider)
    }

    override func tearDown() {
        useCase = nil
        super.tearDown()
    }

    func testFetchCharacters() {
        let expectation = self.expectation(description: "Promise response")
        var characters: [Character]?
        var error: Error?

        useCase?.execute(page: 0) { (result) in
            switch result {
            case .success(let object):
                characters = object
            case .failure(let err):
                error = err
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 3.0) { (_) in
            XCTAssertNil(error, "If the response was successful, the error should be nil.")
            XCTAssertNotNil(characters, "if the response was successful, the characters shouldn't be nil.")
        }
    }
}
