//
//  RowViewProductOfertas.swift
//  CompraSmart
//
//  Created by MacOsX on 9/18/24.
//

import SwiftUI

struct RowViewProductOfertas: View {
    var productOfertas: ProductOfertas
    var body: some View {
        HStack{
            productOfertas.avatar
                .resizable()
                .frame(width: 100, height: 100)
                .padding(10)
            VStack(alignment: .leading){
                Text(productOfertas.name).font(.title)
                Text(productOfertas.descrip).font(.subheadline).foregroundColor(.red)
                Text("$ \(String(format: "%0.2f",productOfertas.precio))").font(.subheadline)
            }
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
struct RowViewProductOfertas_Previews: PreviewProvider {
    static var previews: some View {
        RowViewProductOfertas(productOfertas: ProductOfertas(id: 1, name: "Miel", descrip: "2X1 Miel de abeja, 250ml", avatar: Image("miel"), precio: 3.33)).previewLayout(.fixed(width: 400, height: 110))
    }
}
