//
//  Product.swift
//  CompraSmart
//
//  Created by MacOsX on 9/17/24.
//

import SwiftUI
import Foundation

struct Product {
    var id: Int
    var name: String
    var descrip: String
    var avatar: Image
    var avatarName: String // Nuevo: nombre del archivo de imagen
    var precio: Double

    // Función para convertir el modelo a un diccionario (para Firestore)
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
