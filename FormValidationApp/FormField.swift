//
//  Field.swift
//  FormValidationApp
//
//  Created by ladans on 19/08/25.
//

import Foundation

enum FormField: Hashable {
    case name,
         email,
         password,
         phone
    
    var title: String {
        switch self {
        case .name: return "Name"
        case .email: return "Email"
        case .password: return "Password"
        case .phone: return "Phone"
        }
    }
    
    var icon: String {
        switch self {
        case .name: return "person"
        case .email: return "envelope"
        case .password: return "lock"
        case .phone: return "phone"
        }
    }
}
