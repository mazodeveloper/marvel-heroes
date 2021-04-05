//

import Foundation

enum ProviderError: Error, LocalizedError {
    case parse

    var errorDescription: String? {
        switch self {
        case .parse:
            return NSLocalizedString("Cannot parse Data object to Domain object.",
                                     comment: "Parse error")
        }
    }
}
