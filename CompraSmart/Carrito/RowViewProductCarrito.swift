//
//  RowViewProductCarrito.swift
//  CompraSmart
//
//  Created by MacOsX on 9/18/24.
//

import SwiftUI

struct RowViewProductCarrito: View {
    
    var productCarrito: ProductCarrito
    var body: some View {
        HStack{
            productCarrito.avatar
                .resizable()
                .frame(width: 100, height: 100)
                .padding(2)
            VStack(alignment: .leading){
                Text(productCarrito.name).font(.title)
                Text(productCarrito.descrip).font(.subheadline)
                Text("$ \(String(format: "%0.2f",productCarrito.precio))").font(.subheadline)
                Text("Agregados: \(productCarrito.cantidad)").font(.subheadline)
            }
            .padding(5)
            Spacer()
            Image(systemName: "trash")
                .resizable()
                .foregroundColor(Color.black.opacity(0.6))
                .frame(width: 35, height: 35)
                .padding(2)
            
            VStack{
                Image(systemName: "plus.circle")
                    .resizable()
                    .foregroundColor(Color.black.opacity(0.6))
                    .frame(width: 30, height: 30)
                    .padding(2)
                Image(systemName: "minus.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(10)
            }
            .padding(5)
        }
    }
}

struct RowViewProductCarrito_Previews: PreviewProvider {
    static var previews: some View {
        RowViewProductCarrito(productCarrito: ProductCarrito(id: 1, name: "Miel", descrip: "Miel de abeja, 250ml", avatar: Image("miel"), precio: 3.33, cantidad: 1)).previewLayout(.fixed(width: 400, height: 110))
    }
}
