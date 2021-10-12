//
//  NavigationBar.swift.swift
//  SUMAI
//
//  Created by 서영규 on 2021/10/12.
//

import SwiftUI

struct NavigationBar: View {
    @Binding var showmenu: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation(.default) {
                    self.showmenu.toggle()
                }
            }, label: {
                Image(systemName: "line.horizontal.3")
                    .font(.title2)
                Text("")
            })
                .padding(.vertical)
                .padding(.leading, 18)
            
            Image("SUMAILOGO")
                .resizable()
                .scaledToFit()
                .frame(width: 85, height: 30)
            Text("요약")
                .font(Font.custom("NotoSansKR-Medium", size: 30))
                .opacity(0.6)
                .padding(.bottom, 4)
            
            Spacer()
//            Button(action: {print("login")}, label: {
//                Image(systemName: "person.circle.fill")
//                    .font(.title3)
//                Text("로그인")
//                    .font(Font.custom("NotoSansKR-Medium", size: 17))
//            })
//            .accentColor(.white)
//            .padding(5.0)
//            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.blue))
        }
        .background(Rectangle().fill(Color.white).shadow(color: Color.black.opacity(0.25), radius: 0.7, x: 0, y: 1))
        .padding(.vertical, 3)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
