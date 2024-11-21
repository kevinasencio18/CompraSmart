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
        db.collection("Carrito")
            .whereField("userId", isEqualTo: userId)
            .whereField("id", isEqualTo: product.id)
            .getDocuments { (snapshot, error) in
                if let snapshot = snapshot, !snapshot.isEmpty {
                    // Si el producto ya existe, incrementa la cantidad
                    for document in snapshot.documents {
                        document.reference.updateData([
                            "quantity": FieldValue.increment(Int64(1))
                        ])
                    }
                } else {
                    // Si no existe, agrégalo con cantidad inicial 1
                    db.collection("Carrito").addDocument(data: product.toDictionary().merging([
                        "userId": userId,
                        "quantity": 1
                    ]) { _, new in new }) { error in
                        if let error = error {
                            print("Error al agregar al carrito: \(error.localizedDescription)")
                        } else {
                            print("Producto agregado al carrito")
                        }
                    }
                }
            }
    }
}
