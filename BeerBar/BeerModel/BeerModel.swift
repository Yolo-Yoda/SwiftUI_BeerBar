import Foundation
import SwiftUI

struct Beer: Identifiable, Codable, Hashable {
    let id: Int
    var name: String?
    let tagline: String?
    let description: String?
    let imageUrl: String?
    let abv: Double
    var price: Int? = 15
}

struct BeerBasket: Identifiable, Hashable {
    
    var id: Int
    var beer: Beer
    var cost: Int {
        return beer.price ?? 15
    }
}


