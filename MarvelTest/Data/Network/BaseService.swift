//
//  BaseService.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 30/03/21.
//

import Foundation
import Alamofire
import AlamofireImage

protocol BaseService {
    func execute<Output: Decodable>(endpoint: Endpoint,
                                    completion: @escaping (Result<Output, Error>) -> Void)
}

final class WebService: BaseService {

    let pathGenerable: PathGenerable

    init(pathGenerable: PathGenerable = MarvelEndpoint()) {
        self.pathGenerable = pathGenerable
    }

    func execute<Output>(endpoint: Endpoint,
                         completion: @escaping (Result<Output, Error>) -> Void) where Output: Decodable {

        let url = pathGenerable.generatePath(for: endpoint)
        AF.request(url,
                   method: .get,
                   parameters: pathGenerable.getQueryParameters())
            .validate { (_, httpResponse, _) -> DataRequest.ValidationResult in

                if (httpResponse.statusCode == 401) {
                    return .failure(NetworkingError.unauthorized)
                }
                if (httpResponse.statusCode == 403) {
                    return .failure(NetworkingError.forbidden)
                }
                if (httpResponse.statusCode == 404) {
                    return .failure(NetworkingError.notFound)
                }
                if (500..<600 ~= httpResponse.statusCode) {
                    return .failure(NetworkingError.server)
                }

                return .success(())
            }
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        completion(.failure(NetworkingError.server))
                        return
                    }
                    
                    do {
                        let characters = try JSONDecoder().decode(Output.self, from: data)
                        completion(.success(characters))
                    } catch {
                        completion(.failure(NetworkingError.decode))
                    }

                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
