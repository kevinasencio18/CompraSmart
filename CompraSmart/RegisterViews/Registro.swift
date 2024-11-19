//
//  Registro.swift
//  CompraSmart
//
//  Created by MacOsX on 9/16/24.
//

import SwiftUI

struct Registro: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var username = ""
    @State private var password = ""
    @State private var passwordRepite = ""
    @State private var name = ""
    @State private var telefono = ""
    @State private var isUsernameExist = false
    @State private var isPasswordIncorrect = false
    @State private var registroExitoso = false
    @State private var isActiveLogin = false//Controla la navegacion a Login al registrarte ya que no hay base de datos
    @State private var isRegistred = false//Controla la navegacion si ya tienes una cuenta
    @State private var camposVacios = false
    
    
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    
                    ZStack{
                        Image("registrarse")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFit()
                    }
                    
//                    Text("Completa el formulario")
//                        .font(.largeTitle)
//                        .bold()
//                        .padding()
//
//                    TextField("Nombre completo", text: $name)
//                        .padding()
//                        .frame(width: 300, height: 50)
//                        .background(Color.black.opacity(0.05))
//                        .cornerRadius(10)
//                        .border(camposVacios ? .red: Color.clear, width: 2)
                    
                    TextField("Correo Electronico", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(isUsernameExist ? .red: Color.clear, width: 2)
                        .border(camposVacios ? .red: Color.clear, width: 2)
                    
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(isPasswordIncorrect ? .red: Color.clear, width: 2)
                        .border(camposVacios ? .red: Color.clear, width: 2)
                    
                    SecureField("Repite la contraseña", text: $passwordRepite)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(isPasswordIncorrect ? .red: Color.clear, width: 2)
                        .border(camposVacios ? .red: Color.clear, width: 2)
                    
//                    TextField("No.Telefono", text: $telefono)
//                        .padding()
//                        .frame(width: 300, height: 50)
//                        .background(Color.black.opacity(0.05))
//                        .cornerRadius(10)
//                        .border(camposVacios ? .red: Color.clear, width: 2)
                        //.border(isUsernameExist ? .red: Color.clear, width: 2)
                    //Agregar validacion para que no sean mas de 9 digitos con el guion
                    
                    Button("Registrarse"){
                        //Autentificar
                        //Verificar que repita la contraseña y que usuario no exista
                        verificarDatos(username: username, password: password, passwordRepite: passwordRepite)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5 )
                    Spacer()
//                    NavigationLink(destination: Login(authenticationViewModel: authenticationViewModel)){
//                        Text("Ya tengo una cuenta")
//                            .foregroundColor(.blue)
//                            .underline()
//                            .padding()
//                    }
                    NavigationLink(destination: Login(authenticationViewModel: authenticationViewModel), isActive: $isActiveLogin){
                        EmptyView()
                    }
                }
            }
//            .toolbar{
//                ToolbarItem(placement: .navigationBarLeading){
//                    Button(action: {
//                        isActiveLogin = true
//                        irLogin()
//                    }, label: {
//                        Image(systemName: "arrow.left")
//                    })
//                }
//            }
            .navigationTitle("Regístrate")
            
        }
        
    }
    //func verificarDatos(username: String,name: String,telefono: String,password: String,passwordRepite: String){
    func verificarDatos(username: String,password: String,passwordRepite: String){
        if !username.isEmpty && !password.isEmpty && !passwordRepite.isEmpty
            //&& !name.isEmpty && !telefono.isEmpty
        {
        if username == "asenciok18" {
            isUsernameExist = true
        }else{
            if password == passwordRepite{
                    irLogin()
            }else{
                camposVacios = false
                isPasswordIncorrect = true
            }
        }
        }else{
            camposVacios = true
        }
    }
    
    func irLogin(){
        camposVacios = false
        isUsernameExist = false
        isPasswordIncorrect = false
        authenticationViewModel.createNewUser(email: username, password: password)
        isActiveLogin = true
    }
}

struct Registro_Previews: PreviewProvider {
    static var previews: some View {
        Registro(authenticationViewModel: AuthenticationViewModel())
    }
}
