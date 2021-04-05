//
//  CharacterPresenterTests.swift
//  MarvelTestTests
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import XCTest
@testable import MarvelTest

final class CharacterPresenterTests: XCTestCase {

    var presenter: CharacterPresenter?

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        presenter = nil
        super.tearDown()
    }

    func testFetchCharacters() {
        let expectation = self.expectation(description: "promise response")
        let character = Character(id: 14,
                                  name: "Spider man",
                                  description: "Peter",
                                  thumbnailURL: nil)
        let mockUseCase = MockCharactersUseCase(result: .success([character]))
        let navigator = CharacterNavigator()

        var viewModels: [CharacterViewModel]?
        var error: Error?
        let viewContract = MockCharactersViewContract { (result) in
            switch result {
            case .success(let object):
                viewModels = object
            case .failure(let err):
                error = err
            }

            expectation.fulfill()
        }

        presenter = CharacterPresenter(charactersUseCase: mockUseCase,
                                       navigator: navigator,
                                       view: viewContract)
        presenter?.getCharacters()

        waitForExpectations(timeout: 3.0) { (_) in
            XCTAssertNil(error, "If the response was successful, the error should be nil.")
            XCTAssertNotNil(viewModels, "if the response was successful, the characters shouldn't be nil.")
        }
    }

    func testFailFetchCharacters() {
        let expectation = self.expectation(description: "promise response")
        let mockUseCase = MockCharactersUseCase(result: .failure(NetworkingError.server))
        let navigator = CharacterNavigator()

        var viewModels: [CharacterViewModel]?
        var error: Error?
        let viewContract = MockCharactersViewContract { (result) in
            switch result {
            case .success(let object):
                viewModels = object
            case .failure(let err):
                error = err
            }

            expectation.fulfill()
        }

        presenter = CharacterPresenter(charactersUseCase: mockUseCase,
                                       navigator: navigator,
                                       view: viewContract)
        presenter?.getCharacters()

        waitForExpectations(timeout: 3.0) { (_) in
            XCTAssertNotNil(error, "If the response failed, the error must have a value.")
            XCTAssertNil(viewModels, "if the response failed, the characters should be nil.")
        }
    }
}
