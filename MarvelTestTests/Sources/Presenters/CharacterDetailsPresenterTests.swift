//
//  CharacterDetailsPresenterTests.swift
//  MarvelTestTests
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import XCTest
@testable import MarvelTest

final class CharacterDetailsPresenterTests: XCTestCase {

    var presenter: CharacterDetailsPresenter?

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
        let mockUseCase = MockCharacterDetailsUseCase(result: .success(character))
        let navigator = CharacterDetailsNavigator()

        var viewModel: CharacterViewModel?
        var error: Error?
        let viewContract = MockCharacterDetailsViewContract { (result) in
            switch result {
            case .success(let object):
                viewModel = object
            case .failure(let err):
                error = err
            }

            expectation.fulfill()
        }

        presenter = CharacterDetailsPresenter(characterDetailsUseCase: mockUseCase,
                                              navigator: navigator,
                                              view: viewContract)
        presenter?.getCharacterDetails(by: character.id)

        waitForExpectations(timeout: 3.0) { (_) in
            XCTAssertNil(error, "If the response was successful, the error should be nil.")
            XCTAssertNotNil(viewModel, "if the response was successful, the character shouldn't be nil.")
        }
    }

    func testFailFetchCharacters() {
        let expectation = self.expectation(description: "promise response")
        let mockUseCase = MockCharacterDetailsUseCase(result: .failure(NetworkingError.server))
        let navigator = CharacterDetailsNavigator()

        var viewModel: CharacterViewModel?
        var error: Error?
        let viewContract = MockCharacterDetailsViewContract { (result) in
            switch result {
            case .success(let object):
                viewModel = object
            case .failure(let err):
                error = err
            }

            expectation.fulfill()
        }

        presenter = CharacterDetailsPresenter(characterDetailsUseCase: mockUseCase,
                                              navigator: navigator,
                                              view: viewContract)
        presenter?.getCharacterDetails(by: 14)

        waitForExpectations(timeout: 3.0) { (_) in
            XCTAssertNotNil(error, "If the response failed, the error must have a value.")
            XCTAssertNil(viewModel, "if the response failed, the characters should be nil.")
        }
    }
}
