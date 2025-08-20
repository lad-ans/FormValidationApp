//
//  Formvalidation.swift
//  FormValidationApp
//
//  Created by ladans on 19/08/25.
//

import Foundation

enum ValidationError: Error {
    case empty,
         invalidName,
         invalidPassword,
         invalidEmail,
         phoneMustPreceededByPlus
}

extension ValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .empty:
            return "Field cannot be empty"
        case .invalidName:
            return "Name must contain first and last name"
        case .invalidPassword:
            return "Password must contain !@#"
        case .invalidEmail:
            return "Email must contain @"
        case .phoneMustPreceededByPlus:
            return "Phone number must be preceded by +"
        }
    }
}

class ValidateForm {
    func perform(
        _ newValue: String,
        onValidate: @escaping(String?) throws(ValidationError) -> Void,
        onResult: @escaping(String?) -> Void,
    ) {
        do {
            try validate(newValue)
            try onValidate(newValue)
            onResult(nil)
        } catch {
            onResult(error.localizedDescription)
        }
    }
    
    private func validate(_ input: String?) throws(ValidationError) {
        guard input != nil && !input!.isEmpty else {
            throw .empty
        }
    }
    
    func validateName(_ input: String?) throws(ValidationError) {
        guard let input else { return }
        
        guard input.split(separator: " ").count > 1 else {
            throw .invalidName
        }
    }
    
    func validatePassword(_ input: String?) throws(ValidationError) {
        guard let input else { return }
        
        guard input.contains("!@#") else {
            throw .invalidPassword
        }
    }
    
    func validateEmail(_ input: String?) throws(ValidationError) {
        guard let input else { return }
        
        guard input.contains("@") else {
            throw .invalidEmail
        }
    }
    
    func validatePhone(_ input: String?) throws(ValidationError) {
        guard let input else { return }
        
        guard input.starts(with: "+") else {
            throw .phoneMustPreceededByPlus
        }
    }
}
