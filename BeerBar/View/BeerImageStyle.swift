import SwiftUI

struct BeerImageStyle: ViewModifier {
    enum Size {
        case medium
        
        func width() -> CGFloat {
            switch self {
            case .medium: return 75
            }
        }
        func height() -> CGFloat {
            switch self {
            case .medium: return 125
            }
        }
    }
    
    let size: Size
    
    func body(content: Content) -> some View {
        return content
            .frame(width: size.width(), height: size.height(),alignment: .center)
            .cornerRadius(5)
            .shadow(radius: 8)
    }
}

extension View {
    func beerImageStyle(size: BeerImageStyle.Size) -> some View {
        return ModifiedContent(content: self, modifier: BeerImageStyle(size: size))
    }
}
