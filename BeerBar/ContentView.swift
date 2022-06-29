//
//  ContentView.swift
//  BeerBar
//
//  Created by Виктор Васильков on 20.06.22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            NavigationView {
                MenuView()
            }
                .tabItem{
                    VStack {
                        Image(systemName: "menucard")
                        Text("Menu")
                    }
                }
            BasketView()
                .tabItem{
                    VStack {
                        Image(systemName: "cart")
                        Text("Basket")
                    }
                }
        }
        .onAppear() {
            UITabBar.appearance().barTintColor = .white
        }
        .accentColor(Color.indigo)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
