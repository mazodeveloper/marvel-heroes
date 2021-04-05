//
//  CharacterDetailsProviderContract.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import Foundation

protocol CharacterDetailsProviderContract {
    func fetchCharacterDetails(by id: Int, completion: @escaping (Result<Character, Error>) -> Void)
}
