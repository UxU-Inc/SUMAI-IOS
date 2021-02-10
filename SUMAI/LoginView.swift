//
//  LoginView.swift
//  SUMAI
//
//  Created by 서영규 on 2021/01/28.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    var width = UIScreen.main.bounds.size.width*0.9
    
    var body: some View {
        ZStack {
//            Spacer().background(Color.blue).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Apptitle
                IDField
                LoginAction()
            }
            .frame(width: width,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
    var Apptitle: some View {
        VStack {
            Text("SUMAI 로그인")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(.medium)
                .padding()
        }
        .frame(maxHeight: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

extension LoginView {
    var IDField: some View {
        VStack {
            TextField("E-mail", text: $email)
                .frame(height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
            SecureField("Password", text: $password)
                .frame(height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
        }
    }
}

struct LoginAction: View {
    var width = UIScreen.main.bounds.size.width*0.9

    var body: some View {
        HStack {
            Button(action: { print("로그인") }) {
                Text("로그인")
                    .frame(width: width, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.vertical)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
            }
        }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

