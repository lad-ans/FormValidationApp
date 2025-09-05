//
//  ContentView.swift
//  FormValidationApp
//
//  Created by ladans on 19/08/25.
//

import SwiftUI

struct HomeView: View {
    @State var name: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    @State var nameError: String?
    @State var phoneError: String?
    @State var emailError: String?
    @State var passwordError: String?
    
    @FocusState var focusedField: FormField?
    @Namespace private var namespace
    @State var currentField: FormField?
    
    let validateForm = ValidateForm()
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Form Validation")
                    .font(Font.largeTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 5)
                
                textfield(
                    $name,
                    for: .name,
                    isError: nameError != nil,
                    errorMessage: nameError,
                )
                .onChange(of: name) {
                    validateForm.perform(
                        name,
                        onValidate: validateForm.validateName,
                        onResult: { state in
                            nameError = state
                        }
                    )
                }
                
                textfield(
                    $phone,
                    for: .phone,
                    isError: phoneError != nil,
                    errorMessage: phoneError,
                )
                .onChange(of: phone) {
                    validateForm.perform(
                        phone,
                        onValidate: validateForm.validatePhone,
                        onResult: { state in
                            phoneError = state
                        }
                    )
                }
                
                textfield(
                    $email,
                    for: .email,
                    isError: emailError != nil,
                    errorMessage: emailError,
                )
                .onChange(of: email) {
                    validateForm.perform(
                        email,
                        onValidate: validateForm.validateEmail,
                        onResult: { state in
                            emailError = state
                        }
                    )
                }
                
                textfield(
                    $password,
                    for: .password,
                    isError: passwordError != nil,
                    errorMessage: passwordError,
                )
                .onChange(of: password) {
                    validateForm.perform(
                        password,
                        onValidate: validateForm.validatePassword,
                        onResult: { state in
                            passwordError = state
                        }
                    )
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    func textfield(
        _ text: Binding<String>,
        for field: FormField,
        isError: Bool = false,
        errorMessage: String? = nil
    ) -> some View {
        let isFocused = focusedField == field
        
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 10) {
                VStack(spacing: 8) {
                    Image(systemName: "\(field.icon)\(isFocused ? ".fill" : "")")
                        .foregroundStyle(isError ? .red : .blue)
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: 30)
                    
                    ZStack {
                        Rectangle()
                            .fill(.clear)
                            .frame(width: 20, height: 3)
                        
                        if currentField == field {
                            Rectangle()
                                .fill(isError ? .red : .blue)
                                .matchedGeometryEffect(id: "PREFFIx_INDICATOR", in: namespace)
                                .frame(width: 20, height: 3)
                        }
                    }
                }
                
                if field == .password {
                    SecureField("Type \(field.title)...", text: text)
                        .focused($focusedField, equals: field)
                        .textfieldStyle(
                            isError: isError,
                            isFocused: isFocused,
                        )
                        .onChange(of: focusedField) {
                            if (field == focusedField) {
                                withAnimation(.bouncy) {
                                    currentField = field
                                }
                            }
                        }
                } else {
                    TextField("Type \(field.title)...", text: text)
                        .focused($focusedField, equals: field)
                        .textfieldStyle(
                            isError: isError,
                            isFocused: isFocused,
                        )
                        .onChange(of: focusedField) {
                            if (field == focusedField) {
                                withAnimation(.bouncy) {
                                    currentField = field
                                }
                            }
                        }
                }
            }
    
            if errorMessage != nil {
                Text(errorMessage!)
                    .font(.body)
                    .foregroundStyle(.red)
                    .padding(.leading, 40)
            }
        }
    }
}

#Preview {
    HomeView()
}
