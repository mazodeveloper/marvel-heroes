//
//  CharacterNavigator.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import UIKit

final class CharacterNavigator: CharacterContract.Navigator {

    private weak var viewController: UIViewController?

    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }

    func presentCharacterDetails(character: CharacterViewModel) {
        let vc = CharacterDetailsViewController.getViewController()
        vc.character = character
        viewController?.navigationController?.pushViewController(vc,
                                                                 animated: true)
    }

    func presentAlert(error: Error) {
        viewController?.presentAlert(error: error)
    }
}
