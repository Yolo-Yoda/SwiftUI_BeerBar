import SwiftUI

struct BasketView: View {
    
    @ObservedObject var basketViewModel: BasketViewModel
    
    var body: some View {
        VStack {
            List(basketViewModel.beerBaskets) { beer in
                BasketCell(basket: beer)
            }
            .listStyle(.plain)
            .navigationTitle("cart")
            HStack {
                Text("Your order")
                    .fontWeight(.bold)
                Spacer()
                Text("\(basketViewModel.cost) $")
                    .fontWeight(.bold)
            }.padding()
            HStack (spacing: 30){
                Button {
                    BasketViewModel.shared.beerBaskets = []
                } label: {
                    Text("Cancel")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: screen.width/4)
                        .background(.red)
                        .cornerRadius(25)
                }
                Button {
                    print("Order")
                } label: {
                    Text("Order")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: screen.width/2.5)
                        .background(.green)
                        .cornerRadius(25)
                }
                
                
            }.padding()
        }
        
    }
}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView(basketViewModel: BasketViewModel.shared)
    }
}
