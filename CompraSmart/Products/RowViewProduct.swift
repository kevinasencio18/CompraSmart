//
//  RowViewProduct.swift
//  CompraSmart
//
//  Created by MacOsX on 9/17/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct RowViewProduct: View {
    var product: Product

    var body: some View {
        HStack {
            product.avatar
                .resizable()
                .frame(width: 100, height: 100)
                .padding(10)
            VStack(alignment: .leading) {
                Text(product.name).font(.title)
                Text(product.descrip).font(.subheadline)
                Text("$ \(String(format: "%0.2f", product.precio))").font(.subheadline)
            }
            Spacer()
            // Botón para agregar al carrito
                       Button(action: {
                           addToCart(product: product)
                       }) {
                           Image(systemName: "plus.circle")
                               .resizable()
                               .foregroundColor(Color.black.opacity(0.6))
                               .frame(width: 50, height: 50)
                               .padding(10)
                       
                }
        }
    }
    
    func addToCart(product: Product) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Usuario no autenticado")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("Carrito").addDocument(data: product.toDictionary().merging(["userId": userId]) { _, new in new }) { error in
            if let error = error {
                print("Error al agregar al carrito: \(error.localizedDescription)")
            } else {
                print("Producto agregado al carrito")
            }
        }
    }
}
