import SwiftUI
import Firebase

struct CartView: View {
    @State private var cartItems: [ProductCart] = []
    @State private var isLoading = true
    @ObservedObject var authenticationViewModel: AuthenticationViewModel

    var totalPrice: Double {
        cartItems.reduce(0) { $0 + ($1.precio * Double($1.quantity)) }
    }

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Cargando...")
                } else if cartItems.isEmpty {
                    Text("Tu carrito está vacío.")
                        .font(.title)
                        .padding()
                } else {
                    List {
                        ForEach(cartItems, id: \.id) { item in
                            HStack {
                                Image(item.avatarName)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .padding(10)
                                VStack(alignment: .leading) {
                                    Text(item.name).font(.title)
                                    Text(item.descrip).font(.subheadline)
                                    Text("$ \(String(format: "%0.2f", item.precio))").font(.subheadline)
                                    Text("Cantidad: \(item.quantity)").font(.subheadline)
                                }
                                Spacer()
                                // Botones para aumentar o disminuir la cantidad
                                VStack {
                                    Button(action: {
                                        updateQuantity(for: item, increment: 1)
                                    }) {
                                        Image(systemName: "plus.circle")
                                            .foregroundColor(.green)
                                            .frame(width: 30, height: 30)
                                    }
                                    Button(action: {
                                        updateQuantity(for: item, increment: -1)
                                    }) {
                                        Image(systemName: "minus.circle")
                                            .foregroundColor(.red)
                                            .frame(width: 30, height: 30)
                                    }
                                }
                                // Botón para eliminar el producto
                                Button(action: {
                                    removeItem(item)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .frame(width: 30, height: 30)
                                }
                            }
                        }
                    }
                    .navigationTitle("Carrito")

                    // Total a pagar y botones
                    VStack {
                        Text("Total a Pagar: $ \(String(format: "%0.2f", totalPrice))")
                            .font(.title2)
                            .padding()
                        HStack {
                            Button(action: {
                                clearCart()
                            }) {
                                Text("Eliminar Carrito")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(8)
                            }
                            Button(action: {
                                payCart()
                            }) {
                                Text("Pagar")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            fetchCartItems()
        }
    }

    // Función para obtener los productos del carrito desde Firebase
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
                    self.cartItems = snapshot.documents.compactMap { doc -> ProductCart? in
                        let data = doc.data()
                        guard
                            let id = data["id"] as? Int,
                            let name = data["name"] as? String,
                            let descrip = data["descrip"] as? String,
                            let avatarName = data["avatarName"] as? String,
                            let precio = data["precio"] as? Double,
                            let quantity = data["quantity"] as? Int
                        else {
                            return nil
                        }
                        return ProductCart(id: id, name: name, descrip: descrip, avatarName: avatarName, precio: precio, quantity: quantity)
                    }
                }
                self.isLoading = false
            }
    }

    // Función para actualizar la cantidad de un producto
    func updateQuantity(for item: ProductCart, increment: Int) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Usuario no autenticado")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("Carrito")
            .whereField("userId", isEqualTo: userId)
            .whereField("id", isEqualTo: item.id)
            .getDocuments { (snapshot, error) in
                if let snapshot = snapshot, let document = snapshot.documents.first {
                    let newQuantity = item.quantity + increment
                    if newQuantity > 0 {
                        document.reference.updateData(["quantity": newQuantity])
                        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
                            cartItems[index].quantity = newQuantity
                        }
                    } else {
                        removeItem(item)
                    }
                }
            }
    }

    // Función para eliminar un producto del carrito
    func removeItem(_ item: ProductCart) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Usuario no autenticado")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("Carrito")
            .whereField("userId", isEqualTo: userId)
            .whereField("id", isEqualTo: item.id)
            .getDocuments { (snapshot, error) in
                if let snapshot = snapshot, let document = snapshot.documents.first {
                    document.reference.delete()
                    cartItems.removeAll { $0.id == item.id }
                }
            }
    }

    // Función para eliminar todo el carrito
    func clearCart() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Usuario no autenticado")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("Carrito")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        document.reference.delete()
                    }
                    cartItems.removeAll()
                }
            }
    }

    // Función para pagar (simulación)
    func payCart() {
        print("Pago realizado. Total: $\(String(format: "%0.2f", totalPrice))")
    }
}
