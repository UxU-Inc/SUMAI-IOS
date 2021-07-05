//
//  MenuView.swift
//  SUMAI
//
//  Created by 서영규 on 2021/02/18.
//

import SwiftUI

struct MenuView: View {
    @Binding var showmenu : Bool
    
    var body: some View {
        VStack{
            HStack(spacing: 8){
                Image("SUMAILOGO")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 85, height: 30)
                Text("요약")
                    .font(Font.custom("NotoSansKR-Medium", size: 30))
                    .opacity(0.6)
                    .padding(.bottom, 4)
                Spacer()
            }
            .padding()
            .padding(.top, 25)
            
            Divider()
            
            Group{
                Button(action: {}) {
                    NavigationLink(destination: PolicyView(index: 0)) {
                        Text("이용약관")
                        Spacer()
                    }
                }
                .padding()
                Button(action: {}) {
                    NavigationLink(destination: PolicyView(index: 1)) {
                        Text("개인정보처리방침")
                        Spacer()
                    }
                }
                .padding()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    NavigationLink(destination: PolicyView(index: 2)) {
                        Text("공지사항")
                        Spacer()
                    }
                }
                .padding()
                
                Divider()
                
                // \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "")
                Button(action: {
                        EmailHelper.shared.sendEmail(subject: "[SUMAI요약] 의견 보내기", body: "보내 주신 의견은 소중하게 활용되지만, 민감한 정보는 공유하지 말아 주세요.", to: "help@sumai.co.kr")
                    
                }) {
                    Text("의견 보내기")
                    Spacer()
                }
                .padding()
                
                Spacer()
                HStack {
                    Text("SUMAI의 다른 서비스")
                        .font(Font.custom("NotoSansKR-Medium", size: 14))
                        .opacity(0.85)
                    Spacer()
                }
                .padding(5)
                
                Button(action: {
                    if let url = URL(string: "https://news.sumai.co.kr") {
                        UIApplication.shared.open(url, options: [:])
                    }
                }) {
                    Image("LOGO")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    Text("뉴스 요약")
                        .font(Font.custom("NotoSansKR-Regular", size: 20))
                        .opacity(0.85)
                    Spacer()
                }
                .padding()
            }
            .font(Font.custom("NotoSansKR-Regular", size: 17))
            .opacity(0.85)
            Spacer()
        }
        .foregroundColor(.primary)
        .padding()
        .frame(width: UIScreen.main.bounds.width / (UIScreen.main.bounds.width < 350 ? 1.4 : 1.5))
        .background(Color.white).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .overlay(Rectangle().stroke(Color.primary.opacity(0.2), lineWidth: 2).shadow(radius: 3).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        .onTapGesture {
            withAnimation(.default) {
                self.showmenu.toggle()
            }
        }
    }
}
