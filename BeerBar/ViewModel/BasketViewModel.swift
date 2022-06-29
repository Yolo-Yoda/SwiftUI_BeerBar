import Combine

final class BasketViewModel: ObservableObject {

    static let shared = BasketViewModel()
    
    private init() { }
   
    @Published var cartBeers = [CartBeer]()
    
    var cost: Int {
        var sum = 0
        for beer in cartBeers {
            sum += beer.cost
        }
        return sum
    }
    
    func addBeerToBasket(_ cartBeer: CartBeer) {
        self.cartBeers.append(cartBeer)
    }
    
    func cancelOrder() {
        cartBeers = []
    }
}
