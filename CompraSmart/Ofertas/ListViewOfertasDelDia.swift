
import SwiftUI

private let productsOfertas = [
    ProductOfertas(id: 1, name: "Miel", descrip: "2X1 Miel de abeja, 250ml", avatar: Image("miel"), precio: 3.33),
    ProductOfertas(id: 2, name: "Chorizo Toledo", descrip: "2X1 Chorizo de pollo, 350g", avatar: Image("chorizoToledo"), precio: 5.52),
    ProductOfertas(id: 3, name: "Galleta Oreo", descrip: "3X1 Galleta Oreo, 12u", avatar: Image("galletaOreo"), precio: 4.33),
    ProductOfertas(id: 4, name: "Mayonesa MCormik", descrip: "2X1 Mayonesa MCormik, 350g", avatar: Image("mayonesaMc"), precio: 6.33),
    ProductOfertas(id: 5, name: "Pan Bimbo", descrip: "2X1 Pan Bimbo blanco, 12u", avatar: Image("panBimbo"), precio: 2.33),
    ProductOfertas(id: 6, name: "Quesadilla Sinai", descrip: "3X1 Quesadilla Sinai, 300g", avatar: Image("quesadillaSinai"), precio: 0.25)
]

struct ListViewOfertasDelDia: View {
    @State private var isActiveMenu = false
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    var body: some View {
        
        List(productsOfertas, id: \.id){ productOfertas in
            RowViewProductOfertas(productOfertas: productOfertas)
        }
        .navigationBarTitle("Ofertas del días:")
    }
}

struct ListViewOfertasDelDia_Previews: PreviewProvider {
    static var previews: some View {
        ListViewOfertasDelDia(authenticationViewModel: AuthenticationViewModel())
    }
}
