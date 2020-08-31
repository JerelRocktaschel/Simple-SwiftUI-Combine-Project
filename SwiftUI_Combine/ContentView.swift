//  ContentView

import Foundation
import Combine
import SwiftUI

struct ContentView: View {

    @ObservedObject private var userAccountViewModel = UserAccountViewModel()
    @State var presentAlert = false
    
    var body: some View {
        Form {
            Section(footer: Text(userAccountViewModel.userIDWarning).foregroundColor(.red)) {
                TextField("UserID", text: $userAccountViewModel.userID)
                    .autocapitalization(.none)
            }
            Section(header: Text(">= 8 char, >= 1 upper, >= 1 lower, >= 1 number, >= 1 special"), footer: Text(userAccountViewModel.passwordWarning).foregroundColor(.red)) {
                SecureField("Password", text: $userAccountViewModel.password)
                SecureField("Password verify", text: $userAccountViewModel.passwordVerify)
            }
            Section {
                Button(action: { self.signUp() }) {
                    Text("Sign up")
                }.disabled(!self.userAccountViewModel.isAcceptable)
            }
        }
        .sheet(isPresented: $presentAlert) {
            SuccessView()
        }
    }
    
    func signUp() {
      presentAlert = true
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Good job. Now we'll take your data.")
    }
}

