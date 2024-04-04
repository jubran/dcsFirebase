//
//  ReusableProfileContent.swift
//  SocialMedia
//
//  Created by جبران on 22/05/1444 AH.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReusableProfileContent: View {
    var user: User
    @State private var ge_bold:User.Fonts = .bold
    @State private var featchedPosts: [Post] = []
    var body: some View {
        HStack(){
            WebImage(url: user.userProfileURL).placeholder{
                Image("default")
                    .resizable()
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 60, height: 60)
            .cornerRadius(60 / 2)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth:1)
                    .frame(width: 60, height: 60)
            )
            .shadow(color: Color.white, radius:5)
            .hAlign(.leading)
            Text(user.userProfileName)
                .font(.custom(ge_bold.rawValue, size: 16).bold())
                .foregroundStyle( Color(red: 0.92, green: 0.35, blue: 0.16))
            Text(user.username)
                .font(.custom(ge_bold.rawValue, size: 16))
                .foregroundStyle( Color(red: 0.92, green: 0.35, blue: 0.16))
                .hAlign(.trailing)
            
            
        }
        .padding(.horizontal,15)
        
    }
}


#Preview {
    ContentView()
}
