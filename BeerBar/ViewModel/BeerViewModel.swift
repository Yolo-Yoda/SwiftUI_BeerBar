import Foundation
import Combine
import SwiftUI

final class BeerViewModel: ObservableObject {
    
    @Published var beersSize = [" 0,5 ", " 1 ", " 2 "]
    
    func getPrice(size: String, beer: Beer) -> Int {
        switch size {
        case " 0,5 ": return beer.price ?? 15 * 1
        case " 1 ": return beer.price ?? 15 * 2
        case " 2 ": return beer.price ?? 15 * 4
        default:
            return 15
        }
    }
}
