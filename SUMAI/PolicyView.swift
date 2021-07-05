//
//  PolicyView.swift
//  SUMAI
//
//  Created by 서영규 on 2021/02/18.
//

import SwiftUI

struct PolicyView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @State var index = 0
    var policyData = PolicyData()
    
    var body: some View {
        VStack{
            HStack(spacing: 15){
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    print("back")
                }){
                    Image(systemName: "chevron.backward")
                        .font(.title2)
                    Image("SUMAILOGO_W")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 85, height: 30)
                }
                .accentColor(.primary)
                Spacer()
            }
            .padding()
            
            HStack(spacing: 0){
                Text("이용약관")
                    .foregroundColor(self.index == 0 ? .white : Color.black.opacity(0.7))
                    .font(Font.custom("NotoSansKR-Medium", size: UIScreen.main.bounds.width > 350 ? 16 : 12))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                    .background(Color.black.opacity(self.index == 0 ? 0.8 : 0))
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation(.default){
                            self.index = 0
                        }
                    }
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                Text("개인정보처리방침")
                    .foregroundColor(self.index == 1 ? .white : Color.black.opacity(0.7))
                    .font(Font.custom("NotoSansKR-Medium", size: UIScreen.main.bounds.width > 350 ? 16 : 12))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background(Color.black.opacity(self.index == 1 ? 0.8 : 0))
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation(.default){
                            self.index = 1
                        }
                    }
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                Text("공지사항")
                    .foregroundColor(self.index == 2 ? .white : Color.black.opacity(0.7))
                    .font(Font.custom("NotoSansKR-Medium", size: UIScreen.main.bounds.width > 350 ? 16 : 12))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                    .background(Color.black.opacity(self.index == 2 ? 0.8 : 0))
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation(.default){
                            self.index = 2
                        }
                    }
            }
            .background(Color.black.opacity(0.06))
            .clipShape(Capsule())
            .padding(.horizontal, 5)
            
            TabView(selection: self.$index){
                GridView(policy_Data: policyData.terms)
                    .tag(0)
                GridView(policy_Data: policyData.privacy)
                    .tag(1)
                GridView(policy_Data: policyData.notices)
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }
}

struct GridView : View {
    var policy_Data : [ContentStruct]
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 1)
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(policy_Data){ data in
                    VStack(alignment: .leading, spacing: 15){
                        HStack{
                            Text(data.title)
                                .font(Font.custom("NotoSansKR-Medium", size: 26))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .lineSpacing(3)
                                .padding(.horizontal)
                                .padding(.top)
                            Spacer()
                        }
                        Text(data.text)
                            .font(Font.custom("NotoSansKR-Regular", size: 16))
                            .lineSpacing(3)
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct PolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PolicyView()
    }
}
