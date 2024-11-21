//
//  CartView.swift
//  CompraSmart
//
//  Created by MacOsX on 11/21/24.
//

import SwiftUI
import Firebase

struct CartView: View {
    @State private var cartItems: [Product] = []
    @State private var isLoading = true
    @ObservedObject var authenticationViewModel: AuthenticationViewModel

    var body: some View {
        NavigationView {
            if isLoading {
                ProgressView("Cargando...")
            } else if cartItems.isEmpty {
                Text("Tu carrito está vacío.")
                    .font(.title)
                    .padding()
            } else {
                List(cartItems, id: \.id) { item in
                    HStack {
                        Image(item.avatarName)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(10)
                        VStack(alignment: .leading) {
                            Text(item.name).font(.title)
                            Text(item.descrip).font(.subheadline)
                            Text("$ \(String(format: "%0.2f", item.precio))").font(.subheadline)
                        }
                    }
                }
                .navigationTitle("Carrito")
            }
        }
        .onAppear {
            fetchCartItems()
        }
    }

    func fetchCartItems() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Usuario no autenticado")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("Carrito")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error al obtener productos del carrito: \(error.localizedDescription)")
                } else if let snapshot = snapshot {
                    self.cartItems = snapshot.documents.compactMap { doc -> Product? in
                        let data = doc.data()
                        guard
                            let id = data["id"] as? Int,
                            let name = data["name"] as? String,
                            let descrip = data["descrip"] as? String,
                            let avatarName = data["avatarName"] as? String,
                            let precio = data["precio"] as? Double
                        else {
                            return nil
                        }
                        return Product(id: id, name: name, descrip: descrip, avatar: Image(avatarName), avatarName: avatarName, precio: precio)
                    }
                }
                self.isLoading = false
            }
    }
}
