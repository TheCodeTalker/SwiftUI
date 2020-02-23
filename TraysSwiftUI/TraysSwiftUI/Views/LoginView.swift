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
    
    var body: some View {
            VStack {

//                Image("logo").resizable().aspectRatio(contentMode: ContentMode.fit)
//                    .frame(width: CGFloat(74.0), height: CGFloat(74.0))
//                    .padding(Edge.Set.bottom, 20)
                
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.blue)
                    .frame(width: 200, height: 200)
                
                Text("Login").bold()
                Text("Explore the world of Swift UI").font(.subheadline)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 70, trailing: 0))

                TextField("email", text: $loginViewModel.user.email)
                .padding()
                .background(Color("flash-white"))
                .cornerRadius(4.0)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))

                SecureField("password", text: $loginViewModel.user.password, onCommit: {
                    debugPrint("updated password")
                })
                .padding().background(Color("flash-white"))
                .cornerRadius(4.0)
                .padding(.bottom, 10)


                HStack {
                    Spacer()
                    Text("Forgot Password?").font(.system(size: 15))
                }.padding(.bottom, 40)

                Button(action: submit) {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Login").foregroundColor(Color.white).bold()
                        Spacer()
                    }
                }.padding().background(Color.green).cornerRadius(CGFloat(4.0))
//                .sheet(isPresented: $showingDetail) {
//                    HomeScreen()
//                }

        }.padding()
    }
    

    
    func submit()  {
//        self.showingDetail.toggle()
//        return
        let result = loginViewModel.validateUser()
        switch result {
        case .success( _):
            goHome()
                //return HomeScreen()
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
