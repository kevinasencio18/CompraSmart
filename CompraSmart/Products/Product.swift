import SwiftUI
import Foundation

struct Product {
    var id: Int
    var name: String
    var descrip: String
    var avatar: Image
    var avatarName: String
    var precio: Double

    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "descrip": descrip,
            "avatarName": avatarName,
            "precio": precio
        ]
    }
}

// Nuevo modelo para manejar cantidades en el carrito
struct ProductCart {
    var id: Int
    var name: String
    var descrip: String
    var avatarName: String
    var precio: Double
    var quantity: Int

    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "descrip": descrip,
            "avatarName": avatarName,
            "precio": precio,
            "quantity": quantity
        ]
    }
}
