//
//  CharactersProviderContract.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 30/03/21.
//

import Foundation

protocol CharactersProviderContract {
    func fetchCharacters(page: Int, completion: @escaping (Result<[Character], Error>) -> Void)
}
