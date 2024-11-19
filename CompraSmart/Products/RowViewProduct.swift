//
//  RowViewProduct.swift
//  CompraSmart
//
//  Created by MacOsX on 9/17/24.
//

import SwiftUI

struct RowViewProduct: View {
    var product: Product
    var body: some View {
        HStack{
            product.avatar
                .resizable()
                .frame(width: 100, height: 100)
                .padding(10)
            VStack(alignment: .leading){
                Text(product.name).font(.title)
                Text(product.descrip).font(.subheadline)
                Text("$ \(String(format: "%0.2f",product.precio))").font(.subheadline)
            }
          
            /*Button("+"){
                //Accion agregar carrito
            }
            .foregroundColor(.red)
            .frame(width: 50, height: 50)
            .background(Color.white.opacity(0.15))
            .cornerRadius(10)
            .border(Color.red)
            .shadow(radius: 5 )*/
            .padding(15)
            Image(systemName: "plus.circle")
                .resizable()
                .foregroundColor(Color.black.opacity(0.6))
                .frame(width: 50, height: 50)
                .padding(10)
            
            Spacer()
        }
    }
}

struct RowViewProduct_Previews: PreviewProvider {
    static var previews: some View {
        RowViewProduct(product: Product(id: 1, name: "Miel", descrip: "Miel de abeja, 250ml", avatar: Image("miel"), precio: 3.33)).previewLayout(.fixed(width: 400, height: 110))
    }
}
 
