import SwiftUI
import FirebaseAuth

//Del Id = 16 en adelante son productos
private let products = [
    Product(id: 17, name: "Jose cuervo", descrip: "Tquila Jose Cuervo ", avatar: Image("cuervo"), avatarName: "cuervo", precio: 18.95),
    Product(id: 18, name: "Arroz", descrip: "arroz san fransisco ", avatar: Image("arrros"), avatarName: "arrros", precio:1),
    Product(id: 19, name: "Galleta Picnic", descrip: "12 galleta Diana pinic, fresa ", avatar: Image("pinic"), avatarName: "pinic", precio:2.25),
    Product(id: 20, name:" Cornflakes", descrip: "Cereal Kelloggs original 500 gr", avatar: Image("cornflakes"), avatarName: "cornflakes", precio:5.75),
    Product(id: 21, name: "Pasta fama", descrip: "Espagueti - 4pack 800g", avatar: Image("pasta"), avatarName: "pasta", precio: 4.75),
    Product(id: 22, name: "Jabon Protex", descrip: " jabon corporal protex, 3pack", avatar: Image("protex"), avatarName: "protex",precio: 2.75),
    Product(id: 23, name: "javon facial Dove", descrip: "Hijiene y bellea, ", avatar: Image("dove"), avatarName: "dove",precio:3.25),
    Product(id: 24, name: "azucar", descrip: "Azucar blanca del cañal ", avatar: Image("azucar"), avatarName: "azucar",precio:0.53),
    Product(id: 25, name: "Raid Accion", descrip: "Insecticida Raid Aerosol Accion Total - 400 ml ", avatar: Image("raid"), avatarName: "raid",precio:5.00),
    Product(id: 26, name: "gel eGo", descrip: " Gel Ego para Hombre Attraction-1000 ml ", avatar: Image("ego"), avatarName: "ego",precio: 5.90),
    Product(id: 27 , name:"enfamil", descrip: " Formula Enfamil premiun promentel-900 g", avatar: Image("enfamil"), avatarName: "enfamil",precio: 41.50),
    Product(id: 28, name: "Mix salvacola", descrip: "Mix Salvacola pague 15 lleve 24 ", avatar: Image("salvacola"), avatarName: "salvacola",precio:5.90),
    Product(id: 29, name: "queso", descrip: "Queso Great Value Cheddar Rallado ", avatar: Image("queso"), avatarName: "queso",precio: 10.60),
    Product(id: 30, name: "Limpiador", descrip: "Limpiador Multiusos Ajax 600 g ", avatar: Image("limpiador"), avatarName: "limpiador",precio: 1.36),
    Product(id: 31, name: "Desinfectante Fabuloso", descrip: "Desinfectante Fabuloso Multiusos Frescura Activa Antibacterial Manzana - 1 gal ", avatar: Image("fabuloso"), avatarName: "fabuloso",precio:5.20),
    Product(id: 32, name: "Mani Great", descrip: " Mani Great Value Con Sal - 978 g", avatar: Image("mani"), avatarName: "mani",precio: 6.45),
    Product(id: 33, name: "Cereal Suli", descrip: " Cereal Suli Hojuela Natural - 1200 g", avatar: Image("suli"), avatarName: "suli",precio:3.75),
    Product(id: 34, name: "Shampoo Dove Óleo", descrip: "Shampoo Dove Óleo Nutrición, Cabello Seco - 1150 ml ", avatar: Image("schampoo"), avatarName: "schampoo",precio:9.35),
    Product(id: 35, name: "Lavaplatos Axion", descrip: "Lavaplatos Axion Limón En Pasta 3 Pack, Arrancagasa - 425 g ", avatar: Image("axxion"), avatarName: "axxion",precio:4.10),
    Product(id: 36, name: "Cloro", descrip: "Cloro Acticolor, original - 3785 ml ", avatar: Image("cloro"), avatarName: "cloro",precio:2.60),
    Product(id: 37, name: "Jugo Old", descrip: " Jugo Old Orchard Arandano 1.89 L", avatar: Image("jugo"), avatarName: "jugo",precio:4.75),
    Product(id: 38, name: "Agua Great", descrip: "Agua Great Value purificada, 35 pack - 500 ml ", avatar: Image("agua"), avatarName: "agua",precio:7.49),
    Product(id: 39, name: "Frijol ", descrip: " Frijol De Seda As De Oros 2Pack 1814 g", avatar: Image("frijol"), avatarName: "frijol",precio:11.95),
    Product(id: 40, name: "Avena Quaker", descrip: " Avena Quaker Nutremas Mosh - 900 g", avatar: Image("avena"), avatarName: "avena",precio:2.90),
    Product(id: 41, name: "Chocolates Hersheys", descrip: "Chocolates Hersheys Miniatures Pack 35Oz ", avatar: Image("chocolate"), avatarName: "chocolate",precio: 25.75),
    Product(id: 42, name: "Dulce Venus", descrip: "Dulce Venus Candy Mix Jumbo - 2267.93 g ", avatar: Image("dulces"), avatarName: "dulces",precio: 8.35),
    Product(id: 43, name: "Semillas de marañón", descrip: "Semillas de marañón Great Value sazonadas con sal - 765 g ", avatar: Image("semillas"), avatarName: "semillas",precio: 10.00),
    Product(id: 44, name: "Boquitas Yummies", descrip: " Boquitas Yummies Ranchitas Natural - 750 g", avatar: Image("boquitas"), avatarName: "boquitas",precio: 4.60),
    Product(id: 45, name: "Aceite Borges Oliva", descrip: " Aceite Borges Oliva Puro - 2000 ml", avatar: Image("oliba"), avatarName: "oliba",precio:32.55)
]

struct ListViewProductos: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var isActiveCarrito = false

    var body: some View {
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
