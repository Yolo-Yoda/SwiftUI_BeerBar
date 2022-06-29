import SwiftUI

struct BeerCell: View {
    
    @ObservedObject var beerViewModel = BeerViewModel ()
    @State var size = " 0,5 "
    
    var beer: Beer
    
    var body: some View {
        VStack {
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
                    HStack {
                        Text("\(beer.tagline ?? "mistake")")
                            .font(.custom("Helvetica Neue", size: 12))
                            .lineLimit(6)
                            .alignmentGuide(.leading) { d in d[.leading]}
                        Spacer()
                    }
                    
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
                Spacer()
                Button{
                    var cartBeer = CartBeer(id: 0, beer: Beer(id: beer.id,
                                                                  name: beer.name,
                                                                  tagline: beer.tagline,
                                                                  description: beer.description,
                                                                  imageUrl: beer.imageUrl,
                                                                  abv: beer.abv))
                    cartBeer.beer.price = beerViewModel.getPrice(size: size, beer: beer)
                    BasketViewModel.shared.addBeerToBasket(cartBeer)
                    
                } label: {
                    Text("Add to Basket")
                    
                }.buttonStyle(.borderless)
                .foregroundColor(.cyan)
                .padding(.horizontal, 1)
            
            }
        }
    }
}

struct BeerCell_Previews: PreviewProvider {
    static var previews: some View {
        BeerCell(beer: Beer(id: 0, name: "Test Beer", tagline: "Tagline", description: "Beer description", imageUrl: "https://images.punkapi.com/v2/13.png", abv: 4.5, price: 10))
    }
}
