import SwiftUI

struct LazyView<Destination: ItemDetailViewProvider, Item>: View where Destination.Item == Item {

    let item: Item?
    let destination: Destination.Type

    init(item: Item?, destination: Destination.Type) {
        self.item = item
        self.destination = destination
    }

    var body: some View {
        if let item {
            destination.init(item: item)
        }
    }
}
