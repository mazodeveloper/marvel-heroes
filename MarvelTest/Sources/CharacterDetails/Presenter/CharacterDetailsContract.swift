//
//  CharacterDetailsContract.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import Foundation

enum CharacterDetailsContract {
    typealias Presenter = CharacterDetailsPresenterContract
    typealias View = CharacterDetailsViewContract
    typealias Navigator = CharacterDetailsNavigatorContract
}

protocol CharacterDetailsPresenterContract {
    func getCharacterDetails(by id: Int)
    func presentAlert(error: Error)
}

protocol CharacterDetailsViewContract: class {
    func render(state: CharacterDetailsViewState)
}

protocol CharacterDetailsNavigatorContract {
    func presentAlert(error: Error)
}

enum CharacterDetailsViewState {
    case clear
    case success(character: CharacterViewModel)
    case failure(error: Error)
}
