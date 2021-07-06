//
//  MainView.swift
//  SUMAI
//
//  Created by 서영규 on 2021/02/10.
//

import SwiftUI
import GoogleMobileAds

struct MainView: View {
    @State private var data: String = ""
    @State private var height : CGFloat = 0
    @State private var summary: String = ""
    @State private var sum_height : CGFloat = 0
    @State private var iskeyboard : Bool = false
    @State private var showmenu : Bool = false
    @State private var count : Int = 0
    @State private var ischange : Bool = true
    
    @ObservedObject private var api = APIComm()
    
    private var interstitial = GADInterstitialController()
    
 
    var body: some View {
        ZStack(alignment: .leading) {
            NavigationView{
                GeometryReader { geometry in
                    ScrollView {
                        ScrollViewReader { scroll in
                            ZStack(alignment: .bottomTrailing){
                                VStack(spacing: 0){
                                    HStack{
                                        Text(" 문장입력")
                                            .font(Font.custom("NotoSansKR-Medium", size: 17))
                                            .opacity(0.7)
                                            .padding()
                                        Spacer()
                                    }
                                    Divider()
                                    
                                    ResizableTF(txt: $data, height: $height, isEditable: true)
                                        .frame(height: max(iskeyboard ? geometry.size.height-100 : height, 150))
                                        .padding()
                                        .padding(.bottom, 10)
                                        .padding(.trailing, 20)
                                        .onChange(of: data) { _ in
                                            ischange = true
                                        }
                                }
                                .background(Color.white)
                                
                                if !data.isEmpty{
                                    Button(action: {
                                        self.data = ""
                                        self.summary = ""
                                    }, label: {
                                        Image(systemName: "xmark")
                                            .padding(8.0)
                                    })
                                    .offset(x: -10, y:-max(iskeyboard ? geometry.size.height-100 : height, 150)+10)
                                }
                                
                                Button(action: {
                                    if !data.isEmpty && ischange {
                                        ischange = false
                                        
                                        api.requestSummary(data: data) { sum in
                                            self.summary = sum
                                        }
                                        
                                        self.count = (count + 1) % 5
                                        if self.count == 4 {
                                            interstitial.showAd()
                                        }
                                        UserDefaults.standard.set(self.count, forKey: "Count")
                                    }
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
                                    .padding(.bottom, 5)
                                    .background(Color.white)
                                    .id("summary")
                                    .onChange(of: sum_height) { _ in
                                        withAnimation(.default) {
                                            if UIScreen.main.bounds.height - 222 < sum_height {
                                                scroll.scrollTo("summary", anchor: .zero)
                                            } else {
                                                scroll.scrollTo("summary", anchor: .bottom)
                                            }
                                        }
                                    }
                            }
                            if !iskeyboard { Spacer(minLength: 50) }
                        }
                    }
                    .shadow(radius: 3)
                    .onAppear {
                        showmenu = false
                        
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
                            
                            iskeyboard = true
                        }
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                            
                            iskeyboard = false
                        }
                        
                        
                        guard let cnt = UserDefaults.standard.value(forKey: "Count") else {return}
                        self.count = cnt as! Int
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
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
                        }
                        ToolbarItem(placement: .navigationBarLeading){
                            HStack(spacing: 8){
                                Image("SUMAILOGO")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 85, height: 30)
                                Text("요약")
                                    .font(Font.custom("NotoSansKR-Medium", size: 30))
                                    .opacity(0.6)
                                    .padding(.bottom, 4)
                            }
                        }
//                        ToolbarItem(placement: .navigationBarTrailing){
//                            Button(action: {print("login")}, label: {
//                                Image(systemName: "person.circle.fill")
//                                    .font(.title3)
//                                Text("로그인")
//                                    .font(Font.custom("NotoSansKR-Medium", size: 17))
//                            })
//                            .accentColor(.white)
//                            .padding(5.0)
//                            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.blue))
//                        }
                    }
                }
            }
            .accentColor(.primary)
            .onTapGesture {
                UIApplication.shared.windows.first?.rootViewController?.view.endEditing(true)
            }
            
            CharLimit(data: $data)  // TextView character limit popup
            
            // Admob banner
            VStack{
                Spacer()
                GADBannerViewController()
                    .frame(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)

            ProgressCircle(loading: $api.loading)  // Summary Progress popup
            
            // MenuView
            GeometryReader { geometry in
                HStack{
                    MenuView(showmenu: self.$showmenu)
                        .offset(x: self.showmenu ? 0 : -UIScreen.main.bounds.width / (UIScreen.main.bounds.width < 350 ? 1.4 : 1.5) - 10)
                    
                    Spacer(minLength: 0)
                }
                .background(Color.primary.opacity(self.showmenu ? 0.2 : 0)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .onTapGesture {
                    withAnimation(.default) {
                        self.showmenu.toggle()
                    }
                }
            }
        }
    }
}

struct CharLimit : View { // TextView character limit popup
    @Binding var data : String
    
    var body: some View {
        if data.count >= 5000 {
            VStack {
                HStack {
                    Spacer()
                    Text("글자 수 제한: 5000자")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                        .background(Color.black.opacity(0.8))
                        .clipShape(Capsule())
                    Spacer()
                    
                }
                .padding(.top, 50)
                Spacer()
            }
        }
    }
}

struct ProgressCircle : View { // Summary Progress popup
    @Binding var loading : Bool
    
    var body: some View {
        if loading {
            GeometryReader{ geometry in
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(2)
                    Text("요약 중...")
                        .font(Font.custom("NotoSansKR-Regular", size: 14))
                        .padding(.top, 20)
                }
                .padding([.top, .leading, .trailing], 20)
                .padding(.bottom, 7)
                .background(Color.white)
                .cornerRadius(15)
                .offset(x: (geometry.size.width - 92) / 2, y: (geometry.size.height - 110) / 2)
            }
            .background(Color.black.opacity(0.4)).edgesIgnoringSafeArea(.all)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
