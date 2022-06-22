//
//  BasketCell.swift
//  BeerBar
//
//  Created by Виктор Васильков on 21.06.22.
//

import SwiftUI

struct BasketCell: View {
    
    let basket: BeerBasket
    
    var body: some View {
        HStack {
            Text("\(basket.beer.id).")
            Text(basket.beer.name ?? "")
                .fontWeight(.bold)
            Spacer()
            Text("\(basket.cost) $")
                .fontWeight(.bold)
                .frame(width: 80, alignment: .trailing)
        }.padding(.horizontal)
    }
}

struct BasketCell_Previews: PreviewProvider {
    static var previews: some View {
        BasketCell(
            basket: BeerBasket(id: 1, beer: Beer(id: 11,
                                                 name: "Misspent Youth",
                                                 tagline: "Milk & Honey Scotch Ale.",
                                                 description: "The brainchild of our small batch brewer, George Woods. A dangerously drinkable milk sugar",
                                                 imageUrl: "https://images.punkapi.com/v2/keg.png",
                                                 abv: 7.3,
                                                 price: 15)))
    }
}
