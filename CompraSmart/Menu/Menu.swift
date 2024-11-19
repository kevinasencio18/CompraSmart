//
//  Menu.swift
//  CompraSmart
//
//  Created by MacOsX on 9/17/24.
//

import SwiftUI

struct Menu: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var isActiveCarrito = false
    @State private var isActiveProductos = false
    @State private var isActiveOfertasDelDia = false
    @State private var isActiveLogin = false
    
    var body: some View {

        NavigationView{
            
            ZStack{
                VStack{
                    //Imagen del menu
                    Image("menu")
                      .resizable()
                        .frame(width: 300, height: 300)
                        .scaledToFit()
                    
                    HStack{
                        Button(action: {irOfertasDelDia()}){
                            Image("ofertaDelDia")
                               .resizable()
                                 .frame(width: 70, height: 70)
                                 .scaledToFit()
                                .padding()
                            }
                        Text("Ofertas Del Día")
                            .foregroundColor(.black)
                            .frame(width: 200, height: 50)
                            .background(Color.gray.opacity(0.20))
                            .scaledToFit()
                            .cornerRadius(10)
                            .shadow(radius: 5 )
                        }
                    //Imagen de encontrar productos
                    HStack{
                        Button(action: {irProductos()}){
                            Image("encuentraProductos")
                               .resizable()
                                 .frame(width: 70, height: 70)
                                 .scaledToFit()
                                .padding()
                            }
                        Text("Ver Productos")
                            .foregroundColor(.black)
                            .frame(width: 200, height: 50)
                            .background(Color.gray.opacity(0.20))
                            .scaledToFit()
                            .cornerRadius(10)
                            .shadow(radius: 5 )
                        }
                    //Imagen de Tu carrito
                    HStack{
                        Button(action: {irCarrito()}){
                            Image("carritoDeCompras")
                               .resizable()
                                 .frame(width: 70, height: 70)
                                 .scaledToFit()
                                .padding()
                            }
                        Text("Tu Carrito")
                            .foregroundColor(.black)
                            .frame(width: 200, height: 50)
                            .background(Color.gray.opacity(0.20))
                            .scaledToFit()
                            .cornerRadius(10)
                            .shadow(radius: 5 )
                            
                        }
                    }
                }//Fin Zstack
            
            .navigationTitle("Menu")
            .toolbar{
                Button("Cerrar sesión"){
                    authenticationViewModel.logout()
                }
            }
            }//Fin Navigation View
            
        }//Fin body
    
    //Navega a Ofertas del dia al dar click en el boton y asi respectivamente
    func irOfertasDelDia(){
        isActiveOfertasDelDia = true
        NavigationLink(destination: ListViewOfertasDelDia(authenticationViewModel: authenticationViewModel), isActive: $isActiveOfertasDelDia){
            Text("")
                .foregroundColor(.clear)
        }
    }
    func irCarrito(){
        isActiveCarrito = true
        NavigationLink(destination: ListViewCarrito(authenticationViewModel: authenticationViewModel), isActive: $isActiveCarrito){
            Text("")
                .foregroundColor(.clear)
        }
    }
    func irProductos(){
        isActiveProductos = true
        NavigationLink(destination: ListViewProductos(authenticationViewModel: authenticationViewModel), isActive: $isActiveProductos){
            Text("")
                .foregroundColor(.clear)
        }
    }
        func irLogin(){
            NavigationLink(destination: Menu(authenticationViewModel: authenticationViewModel), isActive: $isActiveLogin){
                Text("")
                    .foregroundColor(.clear)
            }
        }
    
    }// Menu: View
//COmmit menu


struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu(authenticationViewModel: AuthenticationViewModel())
    }
}
