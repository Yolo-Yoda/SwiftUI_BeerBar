import Foundation
import Combine
import SwiftUI

final class MenuViewModel: ObservableObject {
    
    @Published var indexEndpoint: Int = 0
    @Published var beers = [Beer]()
    
    init() {
        $indexEndpoint
            .flatMap {
                (indexEndpoint) -> AnyPublisher<[Beer], Never> in
                BeerAPI.shared.fetchBeers(from: Endpoint(index: indexEndpoint)!)
            }
            .assign(to: \.beers, on: self)
            .store(in: &self.cancellableSet)
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    deinit {
        for cancell in cancellableSet {
            cancell.cancel()
        }
    }
}
