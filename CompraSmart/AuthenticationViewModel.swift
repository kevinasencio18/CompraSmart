//
//  AuthenticationViewModel.swift
//  CompraSmart
//
//  Created by MacOsX on 11/18/24.
//

import Foundation

final  class AuthenticationViewModel: ObservableObject{
    
    @Published var user: User?
    @Published var messageError: String?
    
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository = AuthenticationRepository()){
        self.authenticationRepository = authenticationRepository
        getCurrenttUser()
    }
    
    func getCurrenttUser(){
        self.user = authenticationRepository.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String){
        authenticationRepository.creteNewUser(email: email, password: password) { [weak self] result in
            
            switch result{
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    func logout(){
        do{
            try authenticationRepository.logout()
            self.user = nil
        } catch {
            print("Error logout")
        }
    }
}
