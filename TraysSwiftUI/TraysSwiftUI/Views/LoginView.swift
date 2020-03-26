//
//  LoginView.swift
//  TraysSwiftUI
//
//  Created by Abhishek Chandrashekar on 19/02/20.
//  Copyright © 2020 Abhishek Chandrashekar. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var loginViewModel: LoginViewModel
    @State var keyboardHeight: CGFloat = 0
    @State var keyboardAnimationDuration: TimeInterval = 0

    
    var body: some View {
        VStack(alignment: .center, spacing: -10, content: {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.blue)
                    .frame(width: 200, height: 200)
                
                Text("Login").bold().padding().foregroundColor(Color.black)
                Text("Explore the world of Swift UI").font(.subheadline)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0)).foregroundColor(Color.black)
                VStack {
                    CustomTextField(placeholder: "Email", text: $loginViewModel.user.email)
                        .padding()
                        .background(Color.textFieldColor)
                        .cornerRadius(4.0)
                        .padding()
                        .foregroundColor(Color.black)
                    
                    CustomTextField(placeholder: "Password", text: $loginViewModel.user.password,isSecure: true)
                        .padding().background(Color.textFieldColor)
                        .cornerRadius(4.0)
                        .padding()
                        .foregroundColor(Color.black)
                    
                    
                    HStack {
                        Spacer()
                        Text("Forgot Password?").font(.system(size: 15)).foregroundColor(Color.black)
                    }.padding(.bottom, 40)
                        .padding(.trailing, 10)
                    
                    
                    Button(action: submit) {
                        HStack(alignment: .center) {
                            Spacer()
                            Text("Login").foregroundColor(Color.white).bold().foregroundColor(Color.black)
                            Spacer()
                        }
                    }.padding().background(Color.green).cornerRadius(CGFloat(4.0))
                        .shadow(color: Color(red: 163/255, green: 177/255, blue: 198/255), radius: 8, x: 9, y: 9)
                        .foregroundColor(Color(red: 224/255, green: 229/255, blue: 236/255))
                        .background(Color(red: 224/255, green: 229/255, blue: 236/255))
                }.padding(.leading, 10).padding(.trailing, 10)
                //                .sheet(isPresented: $showingDetail) {
                //                    HomeScreen()
                //                }
                

        }).edgesIgnoringSafeArea(.all)
        .padding([.bottom], keyboardHeight)
        .edgesIgnoringSafeArea((keyboardHeight > 0) ? [.bottom] : [])
        .animation(.easeOut(duration: keyboardAnimationDuration))
        .onReceive(
          NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .receive(on: RunLoop.main),
          perform: updateKeyboardHeight
        )
        
    }
    
    private func updateKeyboardHeight(_ notification: Notification) {
      guard let info = notification.userInfo else { return }
      // Get the duration of the keyboard animation
      keyboardAnimationDuration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.25

      guard let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
      // If the top of the frame is at the bottom of the screen, set the height to 0.
      if keyboardFrame.origin.y == UIScreen.main.bounds.height {
        keyboardHeight = 0
      } else {
        // IMPORTANT: This height will _include_ the SafeAreaInset height.
        keyboardHeight = keyboardFrame.height
      }
    }
    
    
    func submit()  {
        UIApplication.shared.endEditing()
        let result = loginViewModel.validateUser()
        switch result {
        case .success( _):
            goHome()
            break
        default: break
            
        }
        
    }
    
    func goHome() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: HomeScreen())
            window.makeKeyAndVisible()
        }
    }
    
}


//Htack,Vstack,Zstack

//state-observable-environment-@Binding(subview)
//https://www.hackingwithswift.com/quick-start/swiftui/whats-the-difference-between-observedobject-state-and-environmentobject
//let objectWillChange = PassthroughSubject<ViewRouter,Never>() ====== $Published from combine
//        didSet {
//    objectWillChange.send(self)
//}


//MV vs ReduxStore vs MVVM
//https://quickbirdstudios.com/blog/swiftui-architecture-redux-mvvm/


struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    var isSecure: Bool = false
    
    var body: some View {
        ZStack {
            if isSecure {
                SecureField(placeholder, text: $text, onCommit: commit)
            }else {
                TextField(placeholder, text: $text, onEditingChanged: editingChanged, onCommit: commit)
            }
        }
    }
}
