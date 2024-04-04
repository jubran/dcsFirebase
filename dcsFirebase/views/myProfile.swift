//
//  myProfile.swift
//  figmaSwift
//
//  Created by جبران on 03/01/2024.
//

import SwiftUI

struct myProfile: View {
    @State private var isDark:Bool = false
    var body: some View {
        NavigationView{
            
            ScrollView{
                
//                AvatarView(image: Image("86718"), size: 100)
//                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .leading)
//                    .padding(.leading,30)
                VStack{
                    Text("Hi, Jobran Almalki")
                        .fontWeight(.bold)
                    Text("You are lucky ")
                        .font(.callout)
                        .foregroundStyle(Color.gray)
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .leading)
                .padding()
                
                Numbers()
                VStack{
                    Text("Prefrence")
                        .font(.title.bold())
                        .foregroundStyle(Color.secondary)
                }
                .padding(.top,30)
                .padding(.horizontal)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .leading)
              
               Toggle("Dark mode",isOn: $isDark)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    myProfile()
}

struct Numbers: View {
    var body: some View {
        HStack(spacing:60){
            VStack{
                Text("100")
                    .font(.title.bold())
                    .frame(alignment: .leading)
                Text("Following")
                    .font(.callout)
                    .foregroundStyle(Color.gray)
            }
            VStack{
                Text("100")
                    .font(.title.bold())
                Text("Followers")
                    .font(.callout)
                    .foregroundStyle(Color.gray)
            }
            VStack{
                Text("100")
                    .font(.title.bold())
                    .frame(alignment: .trailing)
                Text("Shipments")
                    .font(.callout)
                    .foregroundStyle(Color.gray)
            }
        }
        .padding(.top,20)
    }
}

struct PersonalInfo:View {
    @State private var Fname = ""
    var body: some View{
        NavigationView{
            Form{
                Section(header: Text("My Profile")){
                    TextField("Your Name", text: $Fname)
                    Text("sd")
                }
            }
        }
    }
}
