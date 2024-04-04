//
//  MyProfileView.swift
//  figmaSwift
//
//  Created by جبران on 03/01/2024.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import SDWebImageSwiftUI


struct MyProfileView: View {
    @State private var loading:Bool = false
    @State private var isDark:Bool = false
    @State private var ge_bold:UIDevice.Fonts = .bold
    @State private var ge_light:UIDevice.Fonts  = .light
    @State private var myProfile: User?
    @AppStorage("log_status") var logStatus: Bool = false
    @State var errorMessage: String = ""
    @State var showError: Bool = false
    @State var isLoading: Bool = false
    var body: some View {
        VStack {
            VStack {
                myNumbers()
                Spacer().frame(height: 30)
                if let myProfile{
                 showProfileImage(user: myProfile, isDark: $isDark, logStatus: $logStatus,isLoading: $isLoading, ge_bold: $ge_bold)
//                        .frame(width: 120, height: 120)
                        .refreshable {
                            // refresh
                            self.myProfile = nil
                            await fetchUserData()
                        }
                }
                  
                
                
            }
            
        }
        .onAppear{StartNetworkCall()}
        .redacted(reason: loading ? .placeholder: [])
        .task{
            if myProfile != nil{return}
            await fetchUserData()
        }
        
    }
    func StartNetworkCall(){
        loading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            loading = false
        }
    }
    func changeLang(){
        let currentLang = NSLocale.preferredLanguages[0]
//        print("currentLang:\(currentLang)")
        let newLanguage = currentLang == "en" ? "ar" : "en"
//        print("Lang:\(newLanguage)")
        UserDefaults.standard.setValue([newLanguage], forKey: "AppleLanguages")

        
        exit(0)
    }
    func fetchUserData()async{
        guard let userUID = Auth.auth().currentUser?.uid else{return}
        guard let user = try? await Firestore.firestore().collection("Users").document(userUID).getDocument(as: User.self)
        else{return}
        await MainActor.run(body:{
            myProfile = user
        })
    }
    func deleteAccount(){
        isLoading = true
        Task{
            do{
                guard let userUID = Auth.auth().currentUser?.uid else{return}
                let reference = Storage.storage().reference().child("Profile_Images").child(userUID)
                try await reference.delete()
                try await Firestore.firestore().collection("Users").document(userUID).delete()
                try await Auth.auth().currentUser?.delete()
                logStatus = false
            } catch{
                await setError(error)
            }
        }
    }
    func setError(_ error: Error)async{
        await MainActor.run(body:{
            isLoading = false
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

#Preview {
    MyProfileView()
}
struct myNumbers: View {
    var body: some View {
        HStack(spacing:100){
            VStack{
                Text("0")
                    .font(.title2.bold())
                    .frame(alignment: .leading)
                    .foregroundColor(Color(red: 0.92, green: 0.35, blue: 0.16))
                Text("الإشعارات")
                    .font(.callout)
                    .foregroundStyle(Color.gray)
            }
            VStack{
                Text("1")
                    .font(.title2.bold())
                    .foregroundColor(Color(red: 0.92, green: 0.35, blue: 0.16))
                Text("الزملاء")
                    .font(.callout)
                    .foregroundStyle(Color.gray)
            }
            VStack{
                Text("1")
                    .font(.title2.bold())
                    .frame(alignment: .trailing)
                    .foregroundColor(Color(red: 0.92, green: 0.35, blue: 0.16))
                Text("الادخالات")
                    .font(.callout)
                    .foregroundStyle(Color.gray)
            }
        }
        .padding(.top,20)
    }
}

struct showProfileImage:View {
    var user: User
    @Binding var isDark:Bool
    @Binding var logStatus:Bool
    @Binding var isLoading:Bool
    @Binding var ge_bold:UIDevice.Fonts
    var body: some View {
        VStack{
            WebImage(url: user.userProfileURL).placeholder{
                Image("default")
                    .resizable()
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 120, height: 120)
            .cornerRadius(120 / 2)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth:1)
                    .frame(width: 120, height: 120)
            )
            .shadow(color: Color.white, radius:5)
            Text(user.userProfileName)
                .font(.custom(ge_bold.rawValue, size: 18).bold())
                .bold()
            Spacer().frame(height: 30)
           
            VStack(alignment: .leading, spacing: 15) {
                HStack{
                    Image(systemName: "checkmark.seal.fill")
                        .unredacted()
                        .foregroundColor(Color(red: 0.92, green: 0.35, blue: 0.16))
                    Text(user.username)
                        .foregroundColor(Color(red: 0.92, green: 0.35, blue: 0.16))
                }
                HStack {
                    Image(systemName: "envelope")
                        .unredacted()
                    Text(user.userEmail)
                        .foregroundColor(Color(red: 0.92, green: 0.35, blue: 0.16))
                }
                HStack{
                    Image(systemName: "phone")
                        .unredacted()
                    Text(user.userPhone)
                        .foregroundColor(Color(red: 0.92, green: 0.35, blue: 0.16))
                }
                HStack{
                    Image(systemName: "person.2.fill")
                        .unredacted()
                    Text("Operation Shift")
                        .foregroundColor(Color(red: 0.92, green: 0.35, blue: 0.16))
                }
                HStack {
                    Toggle("Dark mode",isOn: $isDark)
                         .padding(.horizontal)
                }
                .frame(width: 200)
            }
            Spacer().frame(height: 20)
            Button{
                logOutUser()
            } label: {
                Text("تحديث")
                    .font(.callout)
                    .bold()
                    .frame(width: 260, height: 50)
                    .background(Color(red: 0.92, green: 0.35, blue: 0.16))
                    .foregroundStyle(Color.white)
                    .cornerRadius(12)
            }
            Button{
                logOutUser()
            } label: {
                Text("تسجيل خروج")
                    .bold()
                    .frame(width: 230, height: 20)
                    .background(.clear)
                    .foregroundStyle(Color.red)
                    .border(1, color: .red)
            }
            .padding()
        }
        
    }
    func logOutUser(){
        isLoading = true
        Task{
            do{
                try? Auth.auth().signOut()
                logStatus = false
            }
        }
    }
}
