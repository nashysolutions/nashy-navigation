import SwiftUI

public protocol ItemDetailViewProvider: View {
    associatedtype Item: Equatable
    var item: Item { get }
    init(item: Item)
}
