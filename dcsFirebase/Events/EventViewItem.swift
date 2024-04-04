//
//  EventViewItem.swift
//  dcsFirebase
//
//  Created by جبران on 14/01/2024.
//
import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestore
import FirebaseStorage
struct EventViewItem: View {
    var event: DcsEvents
    var onUpdate: (DcsEvents)->()
    var onDelete: ()->()
    @AppStorage("user_UID") private var userUID: String = ""
    @State private var docListner: ListenerRegistration?
    var body: some View {
        HStack(spacing:.minimum(40,40)){
            VStack{
                LogoView(image: Image("aramx"), size: 50)
            }
            VStack(alignment:.leading){
                Text(event.eventText)
                Text("Abha To Jazan")
                    .font(.callout)
                    .foregroundStyle(Color.gray)
                    .lineLimit(1)
            }
            VStack(alignment:.trailing){
                Text("01 Jan 2024")
                Text(event.eventNote)
            }
            
        }
        .padding(10)
        .background(Color(red: 0.95, green: 0.94, blue: 0.98))
        .cornerRadius(10)
        .hAlign(.leading)
      
        .onAppear{
            if docListner == nil {
                guard let postID = event.id else {return}
                docListner = Firestore.firestore().collection("Posts").document(postID).addSnapshotListener({ snapshot,
                    error in
                    if let snapshot {
                        if snapshot.exists {
                            if let updatedPost = try? snapshot.data(as: DcsEvents.self){
                                onUpdate(updatedPost)
                            }
                        }else{
                            onDelete()
                        }
                    }
                })
            }
        }
        .onDisappear{
            if let docListner{
                docListner.remove()
                self.docListner = nil
            }
        }
        
    }
    
}



 

