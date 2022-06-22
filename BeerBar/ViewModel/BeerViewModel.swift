import Foundation
import Combine
import SwiftUI

final class BeerViewModel: ObservableObject {
    
    private let api = BeerAPI.shared
    
    @Published var indexEndpoint: Int = 0
    
    @Published var beers = [Beer]()
    
    @Published var beersSize = [" 0,5 ", " 1 ", " 2 "]
    
    
    init() {
        $indexEndpoint
            .flatMap {
                (indexEndpoint) -> AnyPublisher<[Beer], Never> in
                BeerAPI.shared.fetchBeers(from: Endpoint(index: indexEndpoint)!)
            }
            .assign(to: \.beers, on: self)
            .store(in: &self.cancellableSet)
    }
    
    func getPrice(size: String, beer: Beer) -> Int {
        switch size {
        case " 0,5 ": return beer.price ?? 15 * 1
        case " 1 ": return beer.price ?? 15 * 2
        case " 2 ": return beer.price ?? 15 * 4
        default:
            return 15
        }
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    deinit {
        for cancell in cancellableSet {
            cancell.cancel()
        }
    }
}
