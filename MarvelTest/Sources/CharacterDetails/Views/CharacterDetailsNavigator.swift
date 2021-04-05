//
//  CharacterDetailsNavigator.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import UIKit

final class CharacterDetailsNavigator: CharacterDetailsContract.Navigator {

    private weak var viewController: UIViewController?

    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }

    func presentAlert(error: Error) {
        viewController?.presentAlert(error: error)
    }
}
