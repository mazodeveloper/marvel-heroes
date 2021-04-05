//
//  CharacterDetailsPresenter.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import Foundation

final class CharacterDetailsPresenter: CharacterDetailsContract.Presenter {
    private let characterDetailsUseCase: CharacterDetailsUseCaseContract
    private weak var view: CharacterDetailsContract.View?
    private let navigator: CharacterDetailsContract.Navigator
    private var viewState: CharacterDetailsViewState = .clear {
        didSet {
            view?.render(state: viewState)
        }
    }

    init(characterDetailsUseCase: CharacterDetailsUseCaseContract,
         navigator: CharacterDetailsContract.Navigator,
         view: CharacterDetailsContract.View? = nil) {
        self.characterDetailsUseCase = characterDetailsUseCase
        self.navigator = navigator
        self.view = view
    }

    func getCharacterDetails(by id: Int) {
        characterDetailsUseCase.execute(id: id) { [weak self] (result) in
            switch result {
            case .success(let character):
                var description = character.description ?? ""
                description = description.isEmpty ? "This character has no description." : description
                let viewModel = CharacterViewModel(id: character.id,
                                                   name: character.name,
                                                   description: description,
                                                   thumbnailURL: character.thumbnailURL)
                self?.viewState = .success(character: viewModel)
            case .failure(let error):
                self?.viewState = .failure(error: error)
            }
        }
    }

    func presentAlert(error: Error) {
        navigator.presentAlert(error: error)
    }
}
