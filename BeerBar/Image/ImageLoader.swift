import UIKit
import Combine

class ImageLoaderCache {
    
    static let shared = ImageLoaderCache()
    var loaders: NSCache<NSString, ImageLoader> = NSCache()
    
    func loaderFor(beer: Beer) -> ImageLoader {
        let key = NSString(string: "\(beer.id))")
        print(beer)
        if let loader = loaders.object(forKey: key) {
            return loader
        } else {
            //let url = URL(string: beer.image_url ?? "https://image.tmdb.org/t/p/w500//pThyQovXQrw2m0s9x82twj48Jq4.jpg")
//            (beer.image_url != nil && beer.image_url != "null")
//                ? URL(string: beer.image_url!)
//                : nil
            //let loader = ImageLoader(url: beer.image_url)
            let loader = ImageLoader(url: URL(string: beer.imageUrl ?? "https://image.tmdb.org/t/p/w500//pThyQovXQrw2m0s9x82twj48Jq4.jpg") )
            loaders.setObject(loader, forKey: key)
            return loader
        }
    }
}

final class ImageLoader: ObservableObject {
    // input
    @Published var url: URL?
    // output
    @Published var image: UIImage?
    
    init(url: URL?) {
        self.url = url
        $url
            .flatMap { (path) -> AnyPublisher<UIImage?, Never> in
                self.fetchImage(for: url)
            }
            .assign(to: \.image, on: self)
            .store(in: &self.cancellableSet)
    }
    private var cancellableSet: Set<AnyCancellable> = []
    
    private func fetchImage(for url: URL?) -> AnyPublisher <UIImage?, Never> {
        guard url != nil, image == nil else {
            return Just(nil).eraseToAnyPublisher()
        }
        return
            URLSession.shared.dataTaskPublisher(for: url!)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    deinit {
        for cancell in cancellableSet {
            cancell.cancel()
        }
    }
}
