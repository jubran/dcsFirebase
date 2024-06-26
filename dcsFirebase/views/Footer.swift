//
//  Footer.swift
//  figmaSwift
//
//  Created by جبران on 01/01/2024.
//



import SwiftUI

enum BottomBarSelectedTab:Int{
    case home = 0
    case search = 1
    case plus = 2
    case notification = 3
    case profile = 4
}
struct BottomBar: View {
//    @Environment(\.safeAreaInsets) var safeAreaInsets

    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedTab:BottomBarSelectedTab
    var body: some View {

        HStack(spacing: 10){
            //Home
            Button {
                selectedTab = .home
            } label: {
                ZStack{
                    BottomBarButtonView(image: "offers", text: "البحث", isActive: selectedTab == .home)
                }
            }
            
            
            //Search
            Button {
                    selectedTab = .search
                } label: {
                    BottomBarButtonView(image: "myShipmentFill", text: "الأحداث", isActive: selectedTab == .search)
                }
                
                Button {
                    selectedTab = .plus

                } label: {
                    VStack{
                        ZStack{
                            VStack(spacing: 3){
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 60,height: 60)
                                    .foregroundColor(Color(red: 0.92, green: 0.35, blue: 0.16))
                                
                            }
                            VStack(spacing: 3){
                                Image(systemName: "cube.transparent.fill").font(.title).foregroundColor(.white)
                                
                            }
                        }.padding(EdgeInsets(top: (UIDevice.isIPad ? -21 : -23), leading: 0, bottom: 0, trailing: 0))
                            Spacer()
                                                
                    }
                }
                //Notification
                Button {
                    selectedTab = .notification
                } label: {
                    BottomBarButtonView(image: "partner", text: "العمليات", isActive: selectedTab == .notification)
                }
                //Profile
                Button {
                    selectedTab = .profile
                } label: {
                    
                    BottomBarButtonView(image: "userProfile", text: "جبران", isActive: selectedTab == .profile)
                }
            }
            .frame(height: 50)
            .background(
                Image("bottomBarBG").renderingMode(.template).foregroundColor(Color("PrimaryWhite"))
                    )
            .shadow(color: Color("PrimaryBlack").opacity(colorScheme == .dark ? 0.5 : 0.1), radius: 10, x: 0,y: 0)
        
        
    }
}



struct BottomBarButtonView: View {
    
    var image:String
    var text:String
    var isActive:Bool
    @State private var ge_bold:UIDevice.Fonts = .bold
    @State private var ge_light:UIDevice.Fonts  = .light
    var body: some View {
        HStack(spacing: 10){
                GeometryReader{
                    geo in
                    VStack(spacing: UIDevice.isIPad ? 6 : 3){
                        Rectangle()
                            .frame(height: 0)
                        Image(image)
                            .resizable()
                            .frame(width: UIDevice.isIPad ? 30 : 24,height: UIDevice.isIPad ? 30 : 24)
                            .foregroundColor(isActive ?   Color(red: 0.92, green: 0.35, blue: 0.16) : .gray)
                        
                        Text(text)
                            .font(.custom(ge_bold.rawValue, size: 13))
                            .padding(.vertical,8)
                            .foregroundColor(isActive ?  Color(red: 0.92, green: 0.35, blue: 0.16) : .gray)
                    }
                }
            
            
        }
     
    }
}



#Preview {
  
    BottomBar(selectedTab: .constant(.plus))
}


//VStack(spacing: 3){
//   
//    Image("home")
//        .resizable()
//        .frame(width: 30,height: 30)
//        .foregroundColor(Color.white)
//    
//        
//    
//}
