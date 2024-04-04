//
//  Header.swift
//  figmaSwift
//
//  Created by جبران on 01/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct Header: View {
    @State private var ge_bold:UIDevice.Fonts = .bold
    @State private var ge_light:UIDevice.Fonts  = .light
    @State private var myProfile: User?
    @AppStorage("log_status") var logStatus: Bool = false
    @State var errorMessage: String = ""
    @State var showError: Bool = false
    @State var isLoading: Bool = false
    var body: some View {
        
            
                HStack{
                    if let myProfile{
                        ReusableProfileContent(user: myProfile)
                            .refreshable {
                                self.myProfile = nil
                                await fetchUserData()
                            }
                    }else{
                        ProgressView()
                    }
                }
                .task{
                    if myProfile != nil{return}
                    await fetchUserData()
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
    func logOutUser(){
        isLoading = true
        Task{
            do{
                try? Auth.auth().signOut()
                logStatus = false
            }
        }
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





#Preview{
    Header()
}

