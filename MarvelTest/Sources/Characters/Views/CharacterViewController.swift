//
//  CharacterViewController.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 30/03/21.
//

import UIKit

final class CharacterViewController: UIViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var logoImage: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    private var characters = [CharacterViewModel]()
    private lazy var presenter: CharacterContract.Presenter = {
        let useCase = CharacterInjector.provideCharactersUseCase()
        let navigator = CharacterNavigator(viewController: self)
        return CharacterPresenter(charactersUseCase: useCase,
                                  navigator: navigator,
                                  view: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.getCharacters()
    }

    private func setupUI() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alpha = 0.0

        logoImage.layer.cornerRadius = logoImage.frame.height / 2
        logoImage.alpha = 0.9
        logoImage.layer.borderWidth = 4.0
        logoImage.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor

        UIView.animate(withDuration: 0.8, delay: 0, options: [.repeat, .autoreverse]) {
            self.logoImage.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }
    }

    private func stopLoading() {
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.tableView.alpha = 1
            self.logoImage.alpha = 0
        } completion: { (_) in
            self.logoImage.transform = .identity
        }
    }

    private func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.alpha = 0
    }
}

extension CharacterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier,
                                                       for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }

        let character = characters[indexPath.row]
        cell.nameLabel.text = character.name
        if let url = character.thumbnailURL {
            cell.characterImage.af.setImage(withURL: url)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.select(character: characters[indexPath.row])
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.getMoreCharacters(row: indexPath.row)
    }
}

extension CharacterViewController: CharacterContract.View {
    func render(state: CharacterViewState) {
        switch state {
        case .success(let characters):
            self.characters.append(contentsOf: characters)
            tableView.reloadData()
            stopLoading()
            stopActivityIndicator()
        case .failure(let error):
            presenter.presentAlert(error: error)
            stopLoading()
            stopActivityIndicator()
        case .loading:
            activityIndicator.startAnimating()
            activityIndicator.alpha = 1
        case .clear:
            break
        }
    }
}
