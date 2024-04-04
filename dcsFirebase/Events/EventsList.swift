//
//  Showdetails.swift
//  figmaSwift
//
//  Created by جبران on 01/01/2024.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

struct EventList: View {
    @State private var ge_bold:UIDevice.Fonts = .bold
    @State private var ge_light:UIDevice.Fonts  = .light
    @State private var loading:Bool = false
    @State var selectedDate = Date.now

    var body: some View {
        VStack{
            HStack(alignment: .center, spacing:100){
            }
            DatePicker(selection: $selectedDate,displayedComponents: .date){
                
            }
            .id(selectedDate.timeIntervalSince1970)
           
            ShowEvents(selectedDate: $selectedDate)
                .padding(.top, 55)
        }
        .onAppear{StartNetworkCall()}
        .redacted(reason: loading ? .placeholder: [])
    }
    func StartNetworkCall(){
        loading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            loading = false
        }
    }
   
  
    
}
struct ShowEvents:View {
    @State private var loading:Bool = false
    @Binding var selectedDate:Date
    @FirestoreQuery(collectionPath: "Events",predicates: [.where("eventDate" ,  isLessThanOrEqualTo: Date())
]) var allTheFoo: [DcsEvents]


    var body: some View {
        VStack{
            HStack(alignment: .center, spacing:100){
               
            }
            let dataServer1 = selectedDate.formatted(date: .abbreviated, time: .omitted)
            ForEach(allTheFoo.filter {
                $0.eventDate.formatted(date: .abbreviated, time: .omitted) == dataServer1
            }) { foo in
                    VStack{
                        HStack(spacing:.minimum(40,40)){
                            VStack{
                                Text(foo.eventTime.formatted(date:.omitted, time: .shortened))
                                    .font(.caption).bold()
                                    .foregroundColor(.black)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(50 / 4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(.orange.opacity(0.1))
                                            .stroke(Color.orange, lineWidth:1).opacity(0.4)
                                            .frame(width: 60, height: 60)
                                    )
                            }
                            VStack{
                                HStack{
    //                                Text(foo.location)
                                    Text(foo.location)

                                        .hAlign(.leading)
                                    Text(foo.eventStatus)
                                        .hAlign(.trailing)
                                }
                                .frame(width: .infinity)
                                HStack(){
                                    Text(foo.eventText)
                                        .hAlign(.leading)
                                        .font(.callout)
                                        .foregroundStyle(Color(red: 0.92, green: 0.35, blue: 0.16))
                                        .lineLimit(1)
                                }
                                .padding(.top,1)
                                .frame(width: .infinity)
                            }
                        }
                        .padding(10)
                        .background(Color(red: 0.95, green: 0.94, blue: 0.98))
                        .cornerRadius(10)
                        
                    }.padding(.horizontal)
                }
        }
    }
}
#Preview{
    EventList()
}
//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
