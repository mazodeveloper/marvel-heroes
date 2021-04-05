//
//  CharacterDetailsUseCaseTests.swift
//  MarvelTestTests
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import XCTest
@testable import MarvelTest

final class CharacterDetailsUseCaseTests: XCTestCase {

    var useCase: CharacterDetailsUseCase?

    override func setUp() {
        super.setUp()
        let character = Character(id: 14,
                                  name: "Spider man",
                                  description: "Peter",
                                  thumbnailURL: nil)
        let mockProvider = MockCharacterDetailsProvider(result: .success(character))
        useCase = CharacterDetailsUseCase(provider: mockProvider)
    }

    override func tearDown() {
        useCase = nil
        super.tearDown()
    }

    func testFetchCharacterDetailsById() {
        let expectation = self.expectation(description: "Promise response")
        var character: Character?
        var error: Error?

        useCase?.execute(id: 14) { (result) in
            switch result {
            case .success(let object):
                character = object
            case .failure(let err):
                error = err
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 3.0) { (_) in
            XCTAssertNil(error, "If the response was successful, the error should be nil.")
            XCTAssertNotNil(character, "if the response was successful, the character shouldn't be nil.")
        }
    }
}
