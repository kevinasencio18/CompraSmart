//
//  RegistrarTargeta.swift
//  CompraSmart
//
//  Created by MacOsX on 9/18/24.
//

import SwiftUI

let carrito = CartView(authenticationViewModel: AuthenticationViewModel())

struct RegistrarTarjeta: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var noTarjeta = ""
    @State private var fechaVencimiento = ""
    @State private var codigoTarjeta = ""
    @State private var camposVacios = false
    @State private var isActiveMenu = false
    
    var body: some View {
            VStack{
                Image("registrarTargeta")
                    .resizable()
                    .frame(width: 240, height: 240)
                    .scaledToFit()
                
                Text("Completa el formulario")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                TextField("Número de Tarjeta", text: $noTarjeta)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(camposVacios ? .red: Color.clear, width: 2)
                HStack{
                TextField("Ej: 09/26", text: $fechaVencimiento)
                    .padding()
                    .frame(width: 150, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(camposVacios ? .red: Color.clear, width: 2)
                    .border(camposVacios ? .red: Color.clear, width: 2)
                
                SecureField("Pin: ***", text: $codigoTarjeta)
                    .padding()
                    .frame(width: 150, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(camposVacios ? .red: Color.clear, width: 2)
                }.padding(5)
    
                Button("Efectuar Pago"){
                    //Agregar la acion para el boton
                    verificarDatos(noTarjeta: noTarjeta, fechaVencimiento: fechaVencimiento, codigoTarjeta: codigoTarjeta)
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(radius: 5 )
                .padding(3)
                
                NavigationLink(destination: Menu(authenticationViewModel: authenticationViewModel), isActive: $isActiveMenu){
                    EmptyView()
                }
            }
            .navigationTitle("Registro de Tarjeta")
        }
    
    
    func verificarDatos(noTarjeta: String,fechaVencimiento: String,codigoTarjeta: String){
        if !noTarjeta.isEmpty && !codigoTarjeta.isEmpty && !codigoTarjeta.isEmpty{
            camposVacios = false
            irMenu()
        }else{
            camposVacios = true
        }
    }
    func irMenu(){
        carrito.clearCart()
        isActiveMenu=true
    }
}

struct RegistrarTargeta_Previews: PreviewProvider {
    static var previews: some View {
        RegistrarTarjeta(authenticationViewModel: AuthenticationViewModel())
    }
}
