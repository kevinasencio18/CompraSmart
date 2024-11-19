//
//  ListViewProductos.swift
//  CompraSmart
//
//  Created by MacOsX on 9/17/24.
//

import SwiftUI

private let products = [
    Product(id: 1, name: "Miel", descrip: "Miel de abeja, 250ml", avatar: Image("miel"), precio: 3.33),
    Product(id: 2, name: "Chorizo Toledo", descrip: "Chorizo de pollo, 350g", avatar: Image("chorizoToledo"), precio: 5.52),
    Product(id: 3, name: "Galleta Oreo", descrip: "Galleta Oreo, 12u", avatar: Image("galletaOreo"), precio: 4.33),
    Product(id: 4, name: "Mayonesa MCormik", descrip: "Mayonesa MCormik, 350g", avatar: Image("mayonesaMc"), precio: 6.33),
    Product(id: 5, name: "Pan Bimbo", descrip: "Pan Bimbo blanco, 12u", avatar: Image("panBimbo"), precio: 2.33),
    Product(id: 6, name: "Quesadilla Sinai", descrip: "Quesadilla Sinai, 300g", avatar: Image("quesadillaSinai"), precio: 0.25)
]

struct ListViewProductos: View {
    @State private var isActiveMenu = false
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    var body: some View {
        
        NavigationView{
        List(products, id: \.id){ product in
            RowViewProduct(product: product)
        }
        .navigationBarTitle("Lista de Productos:")
        .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        isActiveMenu = true
                       irMenu()
                    },label: {
                        Image(systemName: "arrow.left")
                            .background(Color.black)
                    })
                }
            }
        }
    }
    func irMenu(){
        
        NavigationLink(destination: Menu(authenticationViewModel: authenticationViewModel), isActive: $isActiveMenu){
            Text("")
                .foregroundColor(.clear)
        }
    }
}

struct ListViewProductos_Previews: PreviewProvider {
    static var previews: some View {
        ListViewProductos(authenticationViewModel: AuthenticationViewModel())
    }
}
