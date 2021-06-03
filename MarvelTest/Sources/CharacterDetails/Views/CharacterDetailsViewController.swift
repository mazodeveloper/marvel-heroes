//
//  CharacterDetailsViewController.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 31/03/21.
//

import UIKit

final class CharacterDetailsViewController: UIViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var characterImage: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var characterStackView: UIStackView!
    private let padding: CGFloat = 16
    
    var character: CharacterViewModel?
    static let identifier = "CharacterDetailsViewController"
    private lazy var presenter: CharacterDetailsContract.Presenter = {
        let useCase = CharacterInjector.provideCharacterDetailsUseCase()
        let navigator = CharacterDetailsNavigator(viewController: self)
        return CharacterDetailsPresenter(characterDetailsUseCase: useCase,
                                         navigator: navigator,
                                         view: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let character = character else {
            return
        }
        setupUI()
        presenter.getCharacterDetails(by: character.id)
        title = character.name
    }

    private func setupUI() {
        characterImage.alpha = 0
        activityIndicator.startAnimating()
        characterStackView.layoutMargins = UIEdgeInsets(top: 0,
                                                        left: padding,
                                                        bottom: padding,
                                                        right: padding)
        characterStackView.isLayoutMarginsRelativeArrangement = true
    }

    static func getViewController() -> CharacterDetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: CharacterDetailsViewController.identifier) as! CharacterDetailsViewController
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}

extension CharacterDetailsViewController: CharacterDetailsContract.View {
    func render(state: CharacterDetailsViewState) {
        switch state {
        case .success(let character):
            self.character = character
            nameLabel.text = character.name
            descriptionLabel.text = character.description
            if let url = character.thumbnailURL {
                characterImage.af.setImage(withURL: url)
            }
            activityIndicator.stopAnimating()
            UIView.animate(withDuration: 0.4) {
                self.activityIndicator.alpha = 0
                self.characterImage.alpha = 1
            }
        case .failure(let error):
            presenter.presentAlert(error: error)
        case .clear:
            break
        }
    }
}
