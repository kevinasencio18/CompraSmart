
import SwiftUI

//Del id = 1 al 15 son Ofertas del dia
private let productsOfertas = [
    Product(id: 1, name: "Miel", descrip: "2X1 Miel de abeja, 250ml", avatar: Image("miel"), avatarName: "miel", precio: 3.33),
    Product(id: 2, name: "Chorizo Toledo", descrip: "2X1 Chorizo de pollo, 350g", avatar: Image("chorizoToledo"), avatarName: "chorizoToledo", precio: 5.52),
    Product(id: 3, name: "Galleta Oreo", descrip: "3X1 Galleta Oreo, 12u", avatar: Image("galletaOreo"), avatarName: "galletaOreo", precio: 4.33),
    Product(id: 4, name: "Mayonesa MCormik", descrip: "2X1 Mayonesa MCormik, 350g", avatar: Image("mayonesaMc"), avatarName: "mayonesaMc", precio: 6.33),
    Product(id: 5, name: "Pan Bimbo", descrip: "2X1 Pan Bimbo blanco, 12u", avatar: Image("panBimbo"), avatarName: "panBimbo", precio: 2.33),
    Product(id: 6, name: "Quesadilla Sinai", descrip: "3X1 Quesadilla Sinai, 300g", avatar: Image("quesadillaSinai"), avatarName: "quesadillaSinai", precio: 0.25),
    Product(id: 7, name: "pasta Dental", descrip: "2x1 pasta dental ", avatar: Image("pastaDental"), avatarName: "pastaDental", precio: 5.50),
    Product(id: 8, name: "pan de caja", descrip: "descuento 40% ", avatar: Image("panCaja"), avatarName: "panCaja", precio: 2.5),
    Product(id: 9, name: "yogurt yes", descrip: "6X3 yogurt yess ", avatar: Image("yogurt"), avatarName: "yogurt", precio: 2.75),
    Product(id: 10, name: "Cafe Juan Valdez", descrip: "cafe soluble con sabor a avellana 15% de descuento", avatar: Image("cafeValdes"), avatarName: "cafeValdes", precio: 11.99),
    Product(id: 11, name: "coca ", descrip: "coca cola lata 24 unidades oferta 30% de descuento", avatar: Image("coca"), avatarName: "coca", precio: 13.5),
    Product(id: 12, name: "cafeListo", descrip: "cafe soluble tradicional Nescafe 25% de descuento ", avatar: Image("cafeListo"), avatarName: "cafeListo", precio: 4.50),
    Product(id: 13, name: "leche Pino", descrip: " leche liquida semi descremada descuento del 20%", avatar: Image("lechepino"), avatarName: "lechepino",precio: 5),
    Product(id: 14, name: "shakaLaka", descrip: " 5X3 bebida sabor surtido 120 ml", avatar: Image("shakalaka"), avatarName: "shakalaka",precio: 2.50),
    Product(id: 15, name: "Leche ", descrip: " leche en polvo Australian 800g 350 % descuento", avatar: Image("lechePolvo"), avatarName: "lechePolvo",precio:18.49),
    Product(id: 16, name: "ensure", descrip: " artículos de calidad para cuidar tu salud y la de tu familia 2X30", avatar: Image("ensure"), avatarName: "ensure",precio:30)
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
