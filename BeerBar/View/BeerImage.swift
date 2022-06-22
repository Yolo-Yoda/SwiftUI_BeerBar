import SwiftUI

struct BeerImage: View {
    
    @ObservedObject var imageLoader: ImageLoader
    @State private var animate = false
    
    let beerSize: BeerImageStyle.Size
    
    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .beerImageStyle(size: .medium)
            } else {
                Rectangle()
                    .foregroundColor(.gray)
                    .beerImageStyle(size: beerSize)
                    .overlay(
                        Text(imageLoader.url != nil ? "Loading..." : "")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .rotationEffect(Angle(degrees: animate ? 60 : -60))
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                                    self.animate = true
                                }
                            })
            }
        }
    }
}

struct BeerImage_Previews: PreviewProvider {
    static var previews: some View {
        BeerImage(imageLoader: ImageLoader(url: URL(string: "https://images.punkapi.com/v2/keg.png")), beerSize: BeerImageStyle.Size.medium)
    }
}
