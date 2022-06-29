//
//  BeerDetailView.swift
//  BeerBar
//
//  Created by Виктор Васильков on 28.06.22.
//

import SwiftUI


struct BeerDetailView: View {
    
    var beer: Beer
    
    var body: some View {
        VStack {
            BeerImage(imageLoader: ImageLoaderCache.shared.loaderFor(beer: beer), beerSize: .large)
            Text("\(beer.name ?? "Not Found"): \(beer.price ?? 15)$")
                .font(.custom("Helvetica Neue Bold", size: 18))
                .padding(.vertical, 2)
            Text(beer.tagline ?? "Not Found")
                .font(.custom("Helvetica Neue", size: 16))
                .padding(.vertical, 2)
            Text(beer.description ?? "Not Found")
                .font(.custom("Helvetica Neue", size: 14))
                .padding(.horizontal, 40)
        }
        Spacer()
        NavigationLink {
                        View1_1()
                    } label: {
                        Text("Тыкни для домашки")
                    }
                    .padding(.vertical, 50)
    }
}

struct BeerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BeerDetailView(beer: Beer(id: 0, name: "Test Beer", tagline: "Tagline", description: "Beerdescrdescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptioniption", imageUrl: "https://images.punkapi.com/v2/13.png", abv: 4.5, price: 10))
    }
}
// Delete after hometask
struct View1_1: View {
    var body: some View {
        
        NavigationLink {
            View1_2()
        } label: {
            Text("И еще раз плиз")
        }
    }
}
struct View1_2: View {
    @State private var show_modal: Bool = false
    var body: some View {
        Button(action: {
            show_modal.toggle()
        }, label: {
            Text("Модальное окно")
        })
            .sheet(isPresented: $show_modal) {
                ModalView()
            }
    }
}
struct ModalView: View {
    var body: some View {
        ZStack {
            Color.mint.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            Text("Мы в модальном окне")
        }
    }
}
