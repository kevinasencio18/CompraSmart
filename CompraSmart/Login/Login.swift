//
//  Login.swift
//  CompraSmart
//
//  Created by MacOsX on 9/16/24.
//
// asenciok70@gmail.com
// navidad2024@gmail.com
import SwiftUI

struct Login: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var username = ""
    @State private var password = ""
    @State private var isUsernameIncorrect = false
    @State private var isPasswordIncorrect = false
    @State private var isActiveMenu = false
    
    var body: some View {
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
                        authenticationViewModel.login(email: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .scaledToFit()
                    .shadow(radius: 5 )
                    
                    NavigationLink(destination: Registro(authenticationViewModel: authenticationViewModel)){
                        Text("¿No tienes una cuenta? Regístrate")
                            .foregroundColor(Color.blue)
                            .underline()
                            .padding()
                    }
                    NavigationLink(destination: Menu(authenticationViewModel: authenticationViewModel), isActive: $isActiveMenu){
                        EmptyView()
                    }
                    
                    if let messageError = authenticationViewModel.messageError{
                        Text("\(messageError) ‼️")
                            .bold()
                            .font(.body)
                            .foregroundColor(.red)
                            .padding(.top, 20)
                    }
                }
            }
            .navigationTitle("¡Bienvenido!🏆")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
        
    }

//Prueba commit 2

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(authenticationViewModel: AuthenticationViewModel())
    }
}
