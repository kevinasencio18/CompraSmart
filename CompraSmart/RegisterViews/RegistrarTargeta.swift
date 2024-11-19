//
//  RegistrarTargeta.swift
//  CompraSmart
//
//  Created by MacOsX on 9/18/24.
//

import SwiftUI

struct RegistrarTargeta: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var noTargeta = ""
    @State private var fechaVencimiento = ""
    @State private var codigoTargeta = ""
    @State private var camposVacios = false
    @State private var isActiveMenu = false
    
    var body: some View {
        NavigationView{
            VStack{
                Image("registrarTargeta")
                    .resizable()
                    .frame(width: 240, height: 240)
                    .scaledToFit()
                
                Text("Completa el formulario")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                TextField("Número de Targeta", text: $noTargeta)
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
                
                SecureField("Pin: ***", text: $codigoTargeta)
                    .padding()
                    .frame(width: 150, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(camposVacios ? .red: Color.clear, width: 2)
                }.padding(5)
    
                Button("Quitar Targeta"){
                    //Agregar la acion para el boton
                    verificarDatos(noTargeta: noTargeta, fechaVencimiento: fechaVencimiento, codigoTargeta: codigoTargeta)
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(radius: 5 )
                .padding(3)
                
                Button("Actualizar Targeta"){
                    //Agregar la acion para el boton
                    verificarDatos(noTargeta: noTargeta, fechaVencimiento: fechaVencimiento, codigoTargeta: codigoTargeta)
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(radius: 5 )
                .padding(3)
                
                Button("Guardar Targeta"){
                    //Agregar la acion para el boton
                    verificarDatos(noTargeta: noTargeta, fechaVencimiento: fechaVencimiento, codigoTargeta: codigoTargeta)
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(radius: 5 )
                .padding(3)
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        isActiveMenu = true
                        irMenu()
                    }, label: {
                        Image(systemName: "arrow.left")
                    })
                }
            }
            .navigationTitle("Registro de Targeta")
        }
    }
    
    func verificarDatos(noTargeta: String,fechaVencimiento: String,codigoTargeta: String){
        if !noTargeta.isEmpty && !codigoTargeta.isEmpty && !codigoTargeta.isEmpty{
            isActiveMenu = true
            camposVacios = false
            irMenu()
        }else{
            isActiveMenu = false
            camposVacios = true
        }
    }
    func irMenu(){
        NavigationLink(destination: Menu(authenticationViewModel: authenticationViewModel), isActive: $isActiveMenu){
            Text("")
                .foregroundColor(.clear)
        }
    }
}

struct RegistrarTargeta_Previews: PreviewProvider {
    static var previews: some View {
        RegistrarTargeta(authenticationViewModel: AuthenticationViewModel())
    }
}
