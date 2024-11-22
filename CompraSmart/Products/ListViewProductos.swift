import SwiftUI
import FirebaseAuth

private let products = [
    Product(id: 1, name: "Miel", descrip: "Miel de abeja, 250ml", avatar: Image("miel"), avatarName: "miel", precio: 3.33),
    Product(id: 2, name: "Chorizo Toledo", descrip: "Chorizo de pollo, 350g", avatar: Image("chorizoToledo"), avatarName: "chorizoToledo", precio: 5.52),
    Product(id: 3, name: "Galleta Oreo", descrip: "Galleta Oreo, 12u", avatar: Image("galletaOreo"), avatarName: "galletaOreo", precio: 4.33),
    Product(id: 4, name: "Mayonesa MCormik", descrip: "Mayonesa MCormik, 350g", avatar: Image("mayonesaMc"), avatarName: "mayonesaMc", precio: 6.33),
    Product(id: 5, name: "Pan Bimbo", descrip: "Pan Bimbo blanco, 12u", avatar: Image("panBimbo"), avatarName: "panBimbo", precio: 2.33),
    Product(id: 6, name: "Quesadilla Sinai", descrip: "Quesadilla Sinai, 300g", avatar: Image("quesadillaSinai"), avatarName: "quesadillaSinai", precio: 0.25)
]

struct ListViewProductos: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var isActiveCarrito = false

    var body: some View {
        NavigationView {
            VStack {
                List(products, id: \.id) { product in
                    RowViewProduct(product: product)
                }
                    NavigationLink(destination: CartView(authenticationViewModel: authenticationViewModel), isActive: $isActiveCarrito) {
                        EmptyView()
                    }
            }
            .navigationBarTitle("Lista de Productos:")
            .toolbar{
                Button("Ver Carrito"){
                    isActiveCarrito = true
                }
            }
        }
    }
}

struct ListViewProductos_Previews: PreviewProvider {
    static var previews: some View {
        ListViewProductos(authenticationViewModel: AuthenticationViewModel())
    }
}
