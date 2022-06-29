import SwiftUI

struct MenuView: View {
    
    @ObservedObject var menuViewModel = MenuViewModel()
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            Picker("", selection: $menuViewModel.indexEndpoint) {
                Text("All beers").tag(0)
                Text("Random beer").tag(1)
            }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)
            
            List {
                ForEach(menuViewModel.beers, id: \.self) { beer in
                    NavigationLink {
                        BeerDetailView(beer: beer)
                            
                    } label: {
                        BeerCell(beer: beer)
                    }
                    .listRowBackground(Color.gray.opacity(0.105))
                    .navigationTitle("Menu")
                    .navigationBarHidden(true)
                }
                .ignoresSafeArea()
            }
            .background(Color.gray.opacity(0.1))
        }
    }
    
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
