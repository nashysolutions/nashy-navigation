import SwiftUI

public struct NavigationResponder<D: ItemDetailViewProvider> {
    
    @Binding var selection: D.Item?
    
    let destination: D.Type
    
    public init(selection: Binding<D.Item?>, destination: D.Type) {
        self._selection = selection
        self.destination = destination
    }
}

public extension View {
    
    func pushNavigation<D: ItemDetailViewProvider>(_ hello: NavigationResponder<D>) -> some View {
        modifier(Moddy<D>(selection: hello.$selection))
    }
}

private struct Moddy<Build: ItemDetailViewProvider>: ViewModifier {
    
    @Binding var selection: Build.Item?
    
    @State private var isActive: Bool = false
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .onChange(of: selection) { newValue in
                    isActive = (newValue != nil)
                }
                .onAppear {
                    selection = nil
                }
            NavigationLink(
                destination: LazyView(item: selection, destination: Build.self),
                isActive: $isActive,
                label: { EmptyView() }).hidden()
        }
    }
}
