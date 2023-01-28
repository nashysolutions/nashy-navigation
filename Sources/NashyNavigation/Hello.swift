import SwiftUI

public struct Hello<D: ItemDetailViewProvider> {
    
    let selection: D.Item?
    let destination: D.Type
    
    public init(selection: D.Item?, destination: D.Type) {
        self.selection = selection
        self.destination = destination
    }
}

public extension View {
    
    func pushNavigation<D: ItemDetailViewProvider>(_ hello: Hello<D>) -> some View {
        modifier(Moddy<D>(selection: hello.selection))
    }
}

private struct Moddy<Build: ItemDetailViewProvider>: ViewModifier {
    
    let selection: Build.Item?
    
    @State private var isActive: Bool = false
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .onChange(of: selection) { newValue in
                    isActive = (newValue != nil)
                }
            NavigationLink(
                destination: LazyView(item: selection, destination: Build.self),
                isActive: $isActive,
                label: { EmptyView() }).hidden()
        }
    }
}
