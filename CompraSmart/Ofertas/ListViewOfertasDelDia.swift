
import SwiftUI

//Del id = 1 al 15 son Ofertas del dia
private let productsOfertas = [
    Product(id: 1, name: "Miel", descrip: "2X1 Miel de abeja, 250ml", avatar: Image("miel"), avatarName: "miel", precio: 3.33),
    Product(id: 2, name: "Chorizo Toledo", descrip: "2X1 Chorizo de pollo, 350g", avatar: Image("chorizoToledo"), avatarName: "chorizoToledo", precio: 5.52),
    Product(id: 3, name: "Galleta Oreo", descrip: "3X1 Galleta Oreo, 12u", avatar: Image("galletaOreo"), avatarName: "galletaOreo", precio: 4.33),
    Product(id: 4, name: "Mayonesa MCormik", descrip: "2X1 Mayonesa MCormik, 350g", avatar: Image("mayonesaMc"), avatarName: "mayonesaMc", precio: 6.33),
    Product(id: 5, name: "Pan Bimbo", descrip: "2X1 Pan Bimbo blanco, 12u", avatar: Image("panBimbo"), avatarName: "panBimbo", precio: 2.33),
    Product(id: 6, name: "Quesadilla Sinai", descrip: "3X1 Quesadilla Sinai, 300g", avatar: Image("quesadillaSinai"), avatarName: "quesadillaSinai", precio: 0.25)
]

struct ListViewOfertasDelDia: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var isActiveCarrito = false

    var body: some View {
            VStack {
                List(productsOfertas, id: \.id) { product in
                    RowViewProductOfertas(product: product)
                }
                    NavigationLink(destination: CartView(authenticationViewModel: authenticationViewModel), isActive: $isActiveCarrito) {
                        EmptyView()
                    }
            }
            .navigationBarTitle("Ofertas del Día:")
            .toolbar{
                Button("Ver Carrito"){
                    isActiveCarrito = true
                }
            }
        }
}
