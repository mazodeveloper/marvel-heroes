//
//  CharacterPresenter.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import Foundation

final class CharacterPresenter: CharacterContract.Presenter {

    private let charactersUseCase: CharactersUseCaseContract
    private weak var view: CharacterContract.View?
    private let navigator: CharacterContract.Navigator
    private var viewState: CharacterViewState = .clear {
        didSet {
            view?.render(state: viewState)
        }
    }
    private var page = 0
    private var characters = [Character]()
    private var rowsBeforePagination = 8

    init(charactersUseCase: CharactersUseCaseContract,
         navigator: CharacterContract.Navigator,
         view: CharacterContract.View? = nil) {
        self.charactersUseCase = charactersUseCase
        self.navigator = navigator
        self.view = view
    }

    func getCharacters() {
        charactersUseCase.execute(page: page) { [weak self] (result) in
            switch result {
            case .success(let characters):
                self?.characters = characters
                let viewModels = characters.compactMap {
                    CharacterViewModel(id: $0.id,
                                       name: $0.name,
                                       description: $0.description,
                                       thumbnailURL: $0.thumbnailURL)
                }
                self?.viewState = .success(characters:  viewModels)
            case .failure(let error):
                self?.viewState = .failure(error: error)
            }
        }
    }

    func select(character: CharacterViewModel) {
        navigator.presentCharacterDetails(character: character)
    }

    func presentAlert(error: Error) {
        navigator.presentAlert(error: error)
    }

    func getMoreCharacters(row: Int) {
        guard row == characters.count - rowsBeforePagination else {
            return
        }
        page += 1
        viewState = .loading
        charactersUseCase.execute(page: page) { [weak self] (result) in
            switch result {
            case .success(let characters):
                self?.characters.append(contentsOf: characters)
                let viewModels = characters.compactMap {
                    CharacterViewModel(id: $0.id,
                                       name: $0.name,
                                       description: $0.description,
                                       thumbnailURL: $0.thumbnailURL)
                }
                self?.viewState = .success(characters:  viewModels)
            case .failure(let error):
                self?.viewState = .failure(error: error)
            }
        }
    }
}
