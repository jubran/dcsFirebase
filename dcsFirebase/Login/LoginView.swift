//
//  LoginView.swift
//  dcs
//
//  Created by جبران on 20/05/1444 AH.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage
struct LoginView: View {
    @State var emailID: String = ""
    //    @State var username: String = ""
    @State private var ge_bold:User.Fonts = .bold
    @State var password: String = ""
    @State var createAcount: Bool = false
    @State var showError: Bool = false
    @State var errorMessage:String = ""
    @State var isLoading: Bool = false
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    //    @State var username: String = ""
    var body: some View {
        VStack(spacing:20){
            WelcomeText()
            UserImage()
            TextField(NSLocalizedString("البريد الالكتروني", comment: ""),text: $emailID)
                .padding(15)
                .background(.gray.opacity(0.1))
                .cornerRadius(10.0)
                .font(.custom(ge_bold.rawValue, size: 16))
                .foregroundStyle( Color(red: 0.92, green: 0.35, blue: 0.16))
            SecureField(NSLocalizedString("كلمة المرور", comment: ""),text: $password)
                .padding(15)
                .background(.gray.opacity(0.1))
                .cornerRadius(10.0)
                .font(.custom(ge_bold.rawValue, size: 16))
                .foregroundStyle( Color(red: 0.92, green: 0.35, blue: 0.20))
            Button(NSLocalizedString("تسجيل دخول", comment: ""),action: loginUser)
                .font(.custom(ge_bold.rawValue, size: 16).weight(.medium))
                .foregroundColor(.white)
                .frame(width: 200, height: 60)
                .background(Color(red: 0.92, green: 0.35, blue: 0.16))
                .cornerRadius(16)
                .hAlign(.center)
            //                .fillView(.black.opacity(0.8))
            
            
            
            
            HStack{
                Button(NSLocalizedString("طلب عضوية", comment: "")){
                    createAcount.toggle()
                }
                .font(.custom(ge_bold.rawValue, size: 16))
                .foregroundStyle( Color(red: 0.92, green: 0.35, blue: 0.16))
                .fontWeight(.bold)
                Text(NSLocalizedString("لايوجد لدي حساب ؟", comment: ""))
                    .foregroundColor(.gray)
                    .font(.custom(ge_bold.rawValue, size: 14))
                
                
                
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        .padding()
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        .fullScreenCover(isPresented: $createAcount){
            RegisterView()
        }
        .alert(errorMessage,isPresented: $showError,actions: {})
    }
    @ViewBuilder
    func WelcomeText()-> some View{
        ZStack{
            Text("بوابة قسم التشغيل")
                .font(.custom(ge_bold.rawValue, size: 25))
                .foregroundStyle( Color(red: 0.92, green: 0.35, blue: 0.16))
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .vAlign(.bottom)
        }
    }
    
    @ViewBuilder
    func UserImage()-> some View{
        VStack {
//            Text(errorMessage)
                            Image("jo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 250, height: 250)
                                .clipped()
                                .cornerRadius(150)
                                .padding(.bottom, 25)
        }
        
    }
        func loginUser(){
            isLoading = true
            closeKeyboard()
            Task{
                do{
                    try await Auth.auth().signIn(withEmail: emailID, password: password)
                    print("User Found")
                    try await fetchUser()
                }catch {
                   
                    let err = error as NSError
                    switch err.code {
                    case AuthErrorCode.invalidEmail.rawValue:
                        await setError("البريد الالكتروني غير صحيح")
                    case AuthErrorCode.wrongPassword.rawValue:
                      
                        await setError("كلمة المرور غير صحيحة")
                    case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                        await setError("البيانات المدخلة غير صحيحة")
                    case AuthErrorCode.userNotFound.rawValue:
                        await setError("الحساب مجمد")
                    default:  await setError("لم يتم العثور على بيانات")
//                        await setError("unknown error: \(err.localizedDescription)")
                    }
                   
                    
                }
            }
        }
//    func loginUser(){
//        isLoading = true
//        closeKeyboard()
//        Task{
//            do {
//                try await Auth.auth().signIn(withEmail: emailID, password: password){ (auth, error) in //some signIn function
//                    if let x = error {
//                        let err = x as NSError
//                        switch err.code {
//                        case AuthErrorCode.wrongPassword.rawValue:
//                            errorMessage = "wrong password, you big dummy"
//                            
//                        case AuthErrorCode.invalidEmail.rawValue:
//                            print("invalid email - duh")
//                        case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
//                            print("the account already exists")
//                        default:
//                            print("unknown error: \(err.localizedDescription)")
//                        }
//                    }else{
//                        
//                    }
//                }
//            }
//        }
//    }
    func resetPassword(){
        Task{
            do{
                try await Auth.auth().sendPasswordReset(withEmail: emailID)
                print("Link Send")
            }catch{
//                await setError(error)
            }
        }
    }
    func fetchUser()async throws{
        guard let userID = Auth.auth().currentUser?.uid else{return}
        let user = try await Firestore.firestore().collection("Users").document(userID).getDocument(as: User.self)
        await MainActor.run(body:{
            userUID = userID
            userNameStored = user.username
            profileURL = user.userProfileURL
            logStatus = true
        })
    }
    func setError(_ err: String)async{
        await MainActor.run(body:{
            errorMessage = err
            showError.toggle()
            isLoading = false
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        
    }
}
