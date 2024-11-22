import SwiftUI
import Firebase

struct CartView: View {
    @State private var cartItems: [ProductCart] = []
    @State private var isLoading = true
    @State var isActiveTarjeta = false
    @ObservedObject var authenticationViewModel: AuthenticationViewModel

    var totalPrice: Double {
        cartItems.reduce(0) { $0 + ($1.precio * Double($1.quantity)) }
    }

    var body: some View {
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
                            CartItemRow(item: item,
                                      onIncrement: { updateQuantity(for: item, increment: 1) },
                                      onDecrement: { updateQuantity(for: item, increment: -1) },
                                      onDelete: { removeItem(item) })
                                .listRowInsets(EdgeInsets())
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle("Carrito:")

                    NavigationLink(destination: RegistrarTarjeta(authenticationViewModel: authenticationViewModel), isActive: $isActiveTarjeta){
                        EmptyView()
                    }
                    
                    VStack {
                        Text("Total a Pagar:  $\(String(format: "%0.2f", totalPrice))")
                            .font(.title2)
                        HStack {
                            Button(action: {
                                clearCart()
                            }) {
                                Text("Eliminar Carrito")
                                    .foregroundColor(.white)
                                    .frame(width: 165, height: 50)
                                    .background(Color(UIColor(hex: "#D12312")!))
                                    .cornerRadius(8)
                                    
                            }
                            Button(action: {
                                payCart()
                            }) {
                                Text("Pagar")
                                    .foregroundColor(.white)
                                    .frame(width: 165, height: 50)
                                    .background(Color(UIColor(hex: "#359124")!))
                                    .cornerRadius(8)
                                    
                            }
                        }
                    }
                    .padding()
                }
            }
        .onAppear {
            fetchCartItems()
        }
    }

    // Componente separado para cada fila del carrito
    struct CartItemRow: View {
        let item: ProductCart
        let onIncrement: () -> Void
        let onDecrement: () -> Void
        let onDelete: () -> Void

        var body: some View {
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
                
                VStack {
                    Button(action: onIncrement) {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.green)
                            .frame(width: 30, height: 30)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    Button(action: onDecrement) {
                        Image(systemName: "minus.circle")
                            .foregroundColor(.red)
                            .frame(width: 30, height: 30)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                .padding(.horizontal, 8)
                
                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding(.trailing, 16)
            }
            .contentShape(Rectangle())
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
        isActiveTarjeta = true
    }
}
