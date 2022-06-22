//
//  ContentView.swift
//  BeerBar
//
//  Created by Виктор Васильков on 20.06.22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var beerViewModel = BeerViewModel ()
    
    var body: some View {
        
        TabView {
            MenuView()
                .tabItem{
                    VStack {
                        Image(systemName: "menucard")
                        Text("Menu")
                    }
                }
            BasketView(basketViewModel: BasketViewModel.shared)
                .tabItem{
                    VStack {
                        Image(systemName: "cart")
                        Text("Basket")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
