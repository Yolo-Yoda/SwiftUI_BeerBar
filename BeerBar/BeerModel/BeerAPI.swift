import Foundation
import Combine
import UIKit

enum Endpoint {
    
    case allbeers
    case randombeer
    
    var baseURL:URL {URL(string: "https://api.punkapi.com/v2/beers")!}
    
    func path() -> String {
        switch self {
        case.allbeers:
            return "/"
        case .randombeer:
            return "random"
        }
    }
    
    var absoluteURL: URL? {
        let queryURL = baseURL.appendingPathComponent(self.path())
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard let urlComponents = components else {
            return nil
        }
        return urlComponents.url
    }
    init? (index: Int) {
        switch index {
        case 0: self = .allbeers
        case 1: self = .randombeer
        default: return nil
        }
    }
}
struct APIConstants {
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
}

class BeerAPI {
    static let shared = BeerAPI()
    
    func fetch<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data}                                          // 2
            .decode(type: T.self, decoder: APIConstants.jsonDecoder) // 3
            .receive(on: RunLoop.main)                               // 4
            .eraseToAnyPublisher()                                   // 5
    }
    
    func fetchBeers(from endpoint: Endpoint) -> AnyPublisher<[Beer], Never> {
        guard let url = endpoint.absoluteURL else {
            return Just([Beer]()).eraseToAnyPublisher()
        }
        return
        URLSession.shared.dataTaskPublisher(for:url)                    // 1
            .map{$0.data}                                                   // 2
            .decode(type: [Beer].self, decoder: APIConstants.jsonDecoder)
            .map{$0}                                                // 4
            .replaceError(with: [])                                         // 5
            .receive(on: RunLoop.main)                                      // 6
            .eraseToAnyPublisher()                                          // 7
    }
    
    private var subscriptions = Set<AnyCancellable>()
    deinit {
        for cancell in subscriptions {
            cancell.cancel()
        }
    }
}
