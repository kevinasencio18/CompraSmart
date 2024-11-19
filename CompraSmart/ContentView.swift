//
//  ContentView.swift
//  CompraSmart
//
//  Created by MacOsX on 9/16/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack{
            Login(authenticationViewModel: authenticationViewModel);
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(authenticationViewModel: AuthenticationViewModel())
    }
}
