//
//  MainView.swift
//  SUMAI
//
//  Created by 서영규 on 2021/02/10.
//

import SwiftUI

struct MainView: View {
    @State private var data: String = ""
    @State private var summary: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(){
                    TextField("요약할 내용을 입력하세요.", text: $data)
                        .frame(height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding()
                        .background(Color.white)
                    TextField("", text: $summary)
                        .background(Color.white)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
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
                            .font(.title)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "person.circle")
                            .font(.title2)
                    })
                }
            }
        }
        .accentColor(.primary)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
