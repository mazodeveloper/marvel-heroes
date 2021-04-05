//
//  CharacterDetailsProviderTests.swift
//  MarvelTestTests
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import XCTest
@testable import MarvelTest

final class CharacterDetailsProviderTests: XCTestCase {

    var provider: CharacterDetailsProvider?

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        provider = nil
        super.tearDown()
    }

    func testFetchCharacterDetails() {
        let characterEntity = CharacterEntity(id: 14,
                                              name: "Spider man",
                                              description: "Peter",
                                              thumbnail: ThumbnailEntity(path: "image", ext: "jpg"))
        let resultEntity = CharacterResultEntity(results: [characterEntity])
        let dataEntity = CharacterDataEntity(data: resultEntity)

        guard let data = try? JSONEncoder().encode(dataEntity) else {
            return XCTFail("The encode process should be successful.")
        }

        let mockBaseService = MockBaseService(result: .success(data))
        provider = CharacterDetailsProvider(baseService: mockBaseService)

        let expectation = self.expectation(description: "promise response")
        var character: Character?
        var error: Error?
        provider?.fetchCharacterDetails(by: 14) { (result) in
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
            XCTAssertNotNil(character, "if the response was successful, the characters shouldn't be nil.")
        }
    }
}
