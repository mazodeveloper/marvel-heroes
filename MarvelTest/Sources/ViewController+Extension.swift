//
//  ViewController+Extension.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import UIKit

extension UIViewController {
    func presentAlert(error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        let button = UIAlertAction(title: "Ok",
                                   style: .default,
                                   handler: nil)
        alert.addAction(button)

        present(alert, animated: true, completion: nil)
    }
}
