//
//  CharacterContract.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import Foundation

enum CharacterContract {
    typealias Presenter = CharacterPresenterContract
    typealias View = CharacterViewContract
    typealias Navigator = CharacterNavigatorContract
}

protocol CharacterPresenterContract {
    func getCharacters()
    func select(character: CharacterViewModel)
    func presentAlert(error: Error)
    func getMoreCharacters(row: Int)
}

protocol CharacterViewContract: AnyObject {
    func render(state: CharacterViewState)
}

protocol CharacterNavigatorContract {
    func presentCharacterDetails(character: CharacterViewModel)
    func presentAlert(error: Error)
}

enum CharacterViewState {
    case clear
    case success(characters: [CharacterViewModel])
    case failure(error: Error)
    case loading
}
