//
//  Login.swift
//  CompraSmart
//
//  Created by MacOsX on 9/16/24.
//

import SwiftUI

struct Login: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var username = ""
    @State private var password = ""
    @State private var isUsernameIncorrect = false
    @State private var isPasswordIncorrect = false
    @State private var isActiveMenu = false
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    ZStack{
                        Image("inicioLogo")
                          .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFit()
                    }
                    
                    TextField("Usuario", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(isUsernameIncorrect ? .red: Color.clear, width: 2)
                    
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(isPasswordIncorrect ? .red: Color.clear, width: 2)
                    
                    Button("Ingresar"){
                        //Autentificar
                        autentificarUsuario(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .scaledToFit()
                    .shadow(radius: 5 )
                    
                    NavigationLink(destination: Registro(authenticationViewModel: authenticationViewModel)){
                        Text("Olvidé mi contraseña")
                            .foregroundColor(Color.blue)
                            .underline()
                            .padding()
                    }
                    NavigationLink(destination: Registro(authenticationViewModel: authenticationViewModel)){
                        Text("¿No tienes una cuenta? Regístrate")
                            .foregroundColor(Color.blue)
                            .underline()
                            .padding()
                    }
                    NavigationLink(destination: Menu(authenticationViewModel: authenticationViewModel), isActive: $isActiveMenu){
                        EmptyView()
                    }
                    
                }
            }
            .navigationTitle("Bienvenido")
        }
        
    }

    func autentificarUsuario(username: String, password: String){
        if username.lowercased() == "asenciok18"{
            isUsernameIncorrect = false
            
            if password.lowercased() == "1234"{
                isPasswordIncorrect = false
                
                //isActivePage = true
                //Agregar aqui para navegar al inicar el login
                isActiveMenu = true
            }else{
                isPasswordIncorrect = true
            }
        }else{
            isUsernameIncorrect = true
        }
    }

}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(authenticationViewModel: AuthenticationViewModel())
    }
}
