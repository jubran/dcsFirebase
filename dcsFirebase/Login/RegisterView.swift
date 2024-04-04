//
//  RegisterView.swift
//  SocialMedia
//
//  Created by جبران on 22/05/1444 AH.
//


import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage
import PhotosUI

struct RegisterView: View{
    @State var emailID: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    @State var userProfileName:String = ""
    @State var userPhone:String = ""
    @State var userProfilePicData: Data?
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    @State private var ge_bold:User.Fonts = .bold
    
    var body :some View{
        VStack(spacing:10){
            Text(NSLocalizedString("حياك معنا", comment: ""))
                .font(.custom(ge_bold.rawValue, size: 25))
                .foregroundStyle( Color(red: 0.92, green: 0.35, blue: 0.16))
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .vAlign(.bottom)
            ViewThatFits {
                ScrollView(.vertical, showsIndicators: false){
                    HelperView()
                }
                HelperView()
            }
            HStack{
                Button(NSLocalizedString("تسجيل الدخول الآن", comment: "")){
                    dismiss()
                }
                .font(.custom(ge_bold.rawValue, size: 16))
                .foregroundStyle( Color(red: 0.92, green: 0.35, blue: 0.16))
                .fontWeight(.bold)
                .foregroundColor(.black)
                Text(NSLocalizedString("لدي عضوية", comment: ""))
                    .foregroundColor(.gray)
                    .font(.custom(ge_bold.rawValue, size: 16))
                   
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem){ newValue in
            if let newValue {
                Task{
                    do{
                        guard let imageData = try await newValue.loadTransferable(type: Data.self)else{return}
                        await MainActor.run(body:{
                            userProfilePicData = imageData
                        })
                    }catch{
                        
                    }
                }
            }
        }
        .alert(errorMessage, isPresented: $showError, actions:{})
        
    }
    @ViewBuilder
    func HelperView()->some View{
        VStack(spacing: 12){
            ZStack{
                if let userProfilePicData,let image = UIImage(data: userProfilePicData){
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                }else{
                    Image("default")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .contentShape(Circle())
            .onTapGesture {
                showImagePicker.toggle()
            }
            .padding(.top,20)
            
            TextField(NSLocalizedString("الرقم الوظيفي", comment: ""),text: $userName)
                .padding(15)
                .background(.gray.opacity(0.1))
                .cornerRadius(10.0)
                .font(.custom(ge_bold.rawValue, size: 18))
                .foregroundStyle( Color(red: 0.92, green: 0.35, blue: 0.16))
            TextField(NSLocalizedString("الاسم الثنائي", comment: ""),text: $userProfileName)
                .padding(15)
                .background(.gray.opacity(0.1))
                .cornerRadius(10.0)
                .font(.custom(ge_bold.rawValue, size: 18))
                .foregroundStyle( Color(red: 0.92, green: 0.35, blue: 0.16))
            TextField(NSLocalizedString("رقم الجوال", comment: ""),text: $userPhone)
                .padding(15)
                .background(.gray.opacity(0.1))
                .cornerRadius(10.0)
                .font(.custom(ge_bold.rawValue, size: 18))
                .foregroundStyle( Color(red: 0.92, green: 0.35, blue: 0.16))
            TextField(NSLocalizedString("البريد الالكتروني للعمل", comment: ""),text: $emailID)
                .padding(15)
                .background(.gray.opacity(0.1))
                .cornerRadius(10.0)
                .font(.custom(ge_bold.rawValue, size: 18))
                .foregroundStyle( Color(red: 0.92, green: 0.35, blue: 0.16))
            SecureField(NSLocalizedString("كلمة المرور", comment: ""),text: $password)
                .padding(15)
                .background(.gray.opacity(0.1))
                .cornerRadius(10.0)
                .font(.custom(ge_bold.rawValue, size: 18))
                .foregroundStyle( Color(red: 0.92, green: 0.35, blue: 0.16))
            Button (action:registerUser){
                Text(NSLocalizedString("إنشاء عضوية", comment: ""))
                    .foregroundColor(.white)
                    .font(.custom(ge_bold.rawValue, size: 18).weight(.medium))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 30)
                    .hAlign(.center)
                    .hAlign(.center)
                    .fillView(Color(red: 0.92, green: 0.35, blue: 0.16))
                    .cornerRadius(16)
                    
            }
            .disableWithOpacity(userName == "" || emailID == "" || password == "" || userPhone == "" || userProfileName == "" || userProfilePicData == nil)
            .padding(.top,10)
        }
    }
    struct WelcomeText: View {
        var body: some View {
            VStack {
                Text("Dcs Operation")
                    .font(.title)
                    .foregroundColor(.black.opacity(0.7))
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                    .vAlign(.bottom)
            }
        }
    }
    struct UserImage: View {
        var body: some View {
            VStack {
                Image("Dcs")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250, height: 100)
                    .clipped()
                    .cornerRadius(150)
                    .padding(.bottom, 25)
            }
        }
    }
    func registerUser(){
        isLoading = true
        closeKeyboard()
        Task{
            do{
                try await Auth.auth().createUser(withEmail: emailID, password: password)
                guard let userUID = Auth.auth().currentUser?.uid else{return}
                guard let imageData = userProfilePicData else {return}
                let storageRef = Storage.storage().reference().child("Profile_Images").child(userUID)
                let _ = try await storageRef.putDataAsync(imageData)
                let downloadURL = try await storageRef.downloadURL()
                let user = User(username: userName, userUID: userUID, userEmail: emailID, userProfileURL: downloadURL,userPhone: userPhone,userProfileName: userProfileName)
                let _ = try  Firestore.firestore().collection("Users").document(userUID).setData(from: user, completion:{
                    error in
                    if error == nil {
                        print("Saved Successfully")
                        userNameStored = userName
                        self.userUID = userUID
                        profileURL = downloadURL
                        logStatus = true
                    }
                })
            }catch{
                try await Auth.auth().currentUser?.delete()
                await setError(error)
            }
        }
    }
    
    func setError(_ error: Error)async{
        await MainActor.run(body:{
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
    
}
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
