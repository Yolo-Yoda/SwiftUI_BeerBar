import SwiftUI

struct MenuView: View {
    
    @ObservedObject var beerViewModel = BeerViewModel ()
    
    @State var size = "0,5"
    
    
    var body: some View {
        VStack {
            VStack {
                Picker("", selection: $beerViewModel.indexEndpoint) {
                    Text("All beers").tag(0)
                    Text("Random beer").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            List {
                ForEach(beerViewModel.beers, id: \.self) { beer in
                    VStack{
                        HStack {
                            BeerImage(imageLoader: ImageLoaderCache.shared.loaderFor(beer: beer), beerSize: .medium)
                            VStack {
                                HStack{
                                    Text("\(beer.name ?? "mistake")")
                                        .font(.custom("Helvetica Neue Bold", size: 16))
                                    Spacer()
                                    Text("\(beerViewModel.getPrice(size: size, beer: beer))$")
                                        .font(.custom("Helvetica Neue Bold", size: 16))
                                }
                                .frame(alignment: .top)
                                .padding(.vertical, 10)
                                Text("\(beer.description ?? "mistake")")
                                    .font(.custom("Helvetica Neue", size: 12))
                                    .lineLimit(6)
                                    .frame(alignment: .bottomLeading)
                            }
                        }
                        HStack{
                            Text("Choose value: ")
                                .font(.custom("Helvetica Neue Bold", size: 16))
                            
                            
                            Picker("Choosevalue", selection: $size) {
                                ForEach (beerViewModel.beersSize, id: \.self) { item in
                                    Text(item)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        HStack {
                            Button{
                                
                                var beerBasket = BeerBasket(id: 0, beer: Beer(id: beer.id,
                                                                              name: beer.name,
                                                                              tagline: beer.tagline,
                                                                              description: beer.description,
                                                                              imageUrl: beer.imageUrl,
                                                                              abv: beer.abv))
                                beerBasket.beer.price = beerViewModel.getPrice(size: size, beer: beer)
                                BasketViewModel.shared.addBeerToBasket(beerBasket)
                                
                            } label: {
                                Text("Add to Basket")
                                
                            }
                        }
                    }
                    
                }
            }
            .ignoresSafeArea()
        }
    }
    
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
