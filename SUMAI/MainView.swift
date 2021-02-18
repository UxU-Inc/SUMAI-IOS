//
//  MainView.swift
//  SUMAI
//
//  Created by 서영규 on 2021/02/10.
//

import SwiftUI

struct MainView: View {
    @State private var data: String = ""
    @State private var height : CGFloat = 0
    @State private var summary: String = ""
    @State private var sum_height : CGFloat = 0
    @State private var iskeyboard : Bool = false
    
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                VStack{
                    ScrollView{
                        ZStack(alignment: .bottomTrailing){
                            VStack(spacing: 0){
                                HStack{
                                    Text(" 문장입력")
                                        .font(.subheadline)
                                        .padding()
                                    Spacer()
                                }
                                Divider()
                            
                                ResizableTF(txt: $data, height: $height, isEditable: true)
                                    .frame(height: max(iskeyboard ? geometry.size.height-94 : height, 150))
                                    .padding()
                                    .padding(.bottom, 10)
                                    .padding(.trailing, 20)
                            }
                            .background(Color.white)
                            
                            if !data.isEmpty{
                                Button(action: {
                                    print("clear button")
                                    self.data = ""
                                    self.summary = ""
                                }, label: {
                                    Image(systemName: "xmark")
                                        .padding(8.0)
                                })
                                .offset(x: -10, y:-max(iskeyboard ? geometry.size.height-94 : height, 150)+10)
                            }

                            Button(action: {
                                print("request")
                                self.summary=self.data
                            }, label: {
                                Image(systemName: "arrow.forward")
                                    .padding(8.0)
                                    .background(Circle().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/))
                                    .accentColor(.white)
                            })
                            .offset(x: -10, y: -10)
                        }
                        if !summary.isEmpty {
                            ResizableTF(txt: $summary, height: $sum_height, isEditable: false)
                                .frame(height: sum_height)
                                .padding()
                                .background(Color.white)
                                .id("summary")
                        }
                        Spacer()
                    }
                    .shadow(radius: 3)
                    .onAppear {
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
                            
                            iskeyboard = true
                        }
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                            
                            iskeyboard = false
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Button(action: {print("menu")}, label: {
                            Image(systemName: "line.horizontal.3")
                                .font(.title)
                        })
                    }
                    ToolbarItem(placement: .navigationBarLeading){
                        HStack(spacing: 8){
                            Image("SUMAILOGO")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 33)
                            Text("요약")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {print("login")}, label: {
                            Image(systemName: "person.circle.fill")
                                .font(.title3)
                            Text("로그인")
                        })
                        .accentColor(.white)
                        .padding(5.0)
                        .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.blue))
                    }
                }
            }
        }
        .accentColor(.primary)
        .onTapGesture {
            UIApplication.shared.windows.first?.rootViewController?.view.endEditing(true)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
