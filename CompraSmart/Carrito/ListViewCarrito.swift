//
//  ListViewCarrito.swift
//  CompraSmart
//
//  Created by MacOsX on 9/18/24.
//

import SwiftUI

private let productsCarrito = [
    ProductCarrito(id: 1, name: "Miel", descrip: "Miel de abeja, 250ml", avatar: Image("miel"), precio: 3.33, cantidad: 1),
    ProductCarrito(id: 2, name: "Chorizo Toledo", descrip: "Chorizo de pollo, 350g", avatar: Image("chorizoToledo"), precio: 5.52, cantidad: 2),
    ProductCarrito(id: 3, name: "Galleta Oreo", descrip: "Galleta Oreo, 12u", avatar: Image("galletaOreo"), precio: 4.33, cantidad: 1),
    ProductCarrito(id: 4, name: "Mayonesa MCormik", descrip: "Mayonesa MCormik, 350g", avatar: Image("mayonesaMc"), precio: 6.33, cantidad: 1),
    ProductCarrito(id: 5, name: "Pan Bimbo", descrip: "Pan Bimbo blanco, 12u", avatar: Image("panBimbo"), precio: 2.33, cantidad: 1),
    ProductCarrito(id: 6, name: "Quesadilla Sinai", descrip: "Quesadilla Sinai, 300g", avatar: Image("quesadillaSinai"), precio: 0.25, cantidad: 3)
]

struct ListViewCarrito: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var isActiveMenu = false
    
    var body: some View {
        
        
        NavigationView{
            VStack{
        List(productsCarrito, id: \.id){ productCarrito in
            RowViewProductCarrito(productCarrito: productCarrito)
        }
                Text("Total a Pagar: $28.11").font(.title)
                HStack{
                    Button("Pagar"){
                        //Autentificar
                    }
                    .foregroundColor(.white)
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .scaledToFit()
                    .shadow(radius: 5 )
                    
                    Button("Vaciar Todo"){
                        //Autentificar
                    }
                    .foregroundColor(.white)
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .scaledToFit()
                    .shadow(radius: 5 )
                }
        }
        .navigationBarTitle("Carrito de compras:")
            //ext("Total a Pagar: $28.11")
        }
    }
}

struct ListViewCarrito_Previews: PreviewProvider {
    static var previews: some View {
        ListViewCarrito(authenticationViewModel: AuthenticationViewModel())
    }
}
