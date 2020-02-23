//
//  LoginViewModel.swift
//  TraysSwiftUI
//
//  Created by Abhishek Chandrashekar on 20/02/20.
//  Copyright © 2020 Abhishek Chandrashekar. All rights reserved.
//

import Foundation

class LoginViewModel : ObservableObject{
    
    @Published var user : User
    
    init() {
        user = User()
    }
    
    func validateUser() -> Result<String, CustomError> {
        if user.email.lowercased() == "nca" && user.password.lowercased() == "anc" {
            return .success("Success")
        }
        return .failure(.failed)
    }
    
    
}
