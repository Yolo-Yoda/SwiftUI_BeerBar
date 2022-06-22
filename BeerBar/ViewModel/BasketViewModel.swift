import Combine

final class BasketViewModel: ObservableObject {

    static let shared = BasketViewModel()
    
    private init() { }
   
    @Published var beerBaskets = [BeerBasket]()
    
    var cost: Int {
        var sum = 0
        for beer in beerBaskets {
            sum += beer.cost
        }
        return sum
    }
    
    func addBeerToBasket(_ beerBasket: BeerBasket) {
        self.beerBaskets.append(beerBasket)
    }
}
