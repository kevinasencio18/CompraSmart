//
//  CompraSmartApp.swift
//  CompraSmart
//
//  Created by MacOsX on 9/16/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct CompraSmartApp: App {
    
    //Firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    //Autentificacion
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            if let user = authenticationViewModel.user {
                Menu(authenticationViewModel: authenticationViewModel)
            }else{
                ContentView(authenticationViewModel: authenticationViewModel)
            }
        }
    }
}
