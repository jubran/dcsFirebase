//
//  AddEvent.swift
//  dcsFirebase
//
//  Created by جبران on 13/01/2024.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct AddEvent: View {
    //    var onPost: (DcsEvents)->()
    @Environment(\.dismiss) private var dismiss
    @State var  location:LocationPath1 = .GT29
    @State var  eventDate:Date
    @State var  eventText:String
    @State var  eventStatus:String
    @State var  eventTime:Date
    @State var  eventFSNL:String
    @State var  eventSynch:String
    @State var  eventRatching:String
    @State var  eventNote:String
    @State var  eventUsername:String
    @Binding var ge_bold:UIDevice.Fonts
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    @FocusState private var showKeyboard: Bool
    @State private var postImageData: Data?
    @State private var showError: Bool = false
    @State private var selectedItem: OptionEnum = .START_UNIT
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationStack{
                ZStack{
                    
                }.padding(.top, 1)
                    .frame(width: geometry.size.width, height: 0, alignment: .center)
                ZStack{
                    Rectangle()
                        .fill(Color.gray).opacity(0.1)
                        .cornerRadius(16)
                    VStack(spacing: 5){
                        VStack{
                            
                            Picker("اختيار الموقع", selection: $location){
                                
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.clear)
                                    .frame(width: 350, height: 50, alignment: .trailing)
                                    .overlay{
                                        Label("الوحدات", systemImage: "house")
                                    }
                                ForEach(Array(LocationPath1.allCases), id: \.self) {
                                    Text($0.rawValue).tag($0.rawValue)
                                }
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.clear)
                                    .frame(width: 350, height: 50, alignment: .trailing)
                                    .overlay{
                                        Label("المنقيات", systemImage: "d")
                                    }
                                ForEach(Array(LocationFTC.allCases), id: \.self) {
                                    Text($0.rawValue).tag($0.rawValue)
                                }
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.clear)
                                    .frame(width: 350, height: 50, alignment: .trailing)
                                    .overlay{
                                        Label("التفريغ", systemImage: "d")
                                    }
                                ForEach(Array(FUS.allCases), id: \.self) {
                                    Text($0.rawValue).tag($0.rawValue)
                                }
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.clear)
                                    .frame(width: 350, height: 50, alignment: .trailing)
                                    .overlay{
                                        Label("خزانات الوقود", systemImage: "d")
                                    }
                                ForEach(Array(Tanks.allCases), id: \.self) {
                                    Text($0.rawValue).tag($0.rawValue)
                                }
                            }
                            .padding()
                            .font(.custom(ge_bold.rawValue, size: 16)).bold()
                            .foregroundStyle(Color(red: 0.92, green: 0.35, blue: 0.16))
                            .pickerStyle(.navigationLink)
                        }
                        .frame(width: geometry.size.width * 0.8, height: 40, alignment: .center).padding([.top,.bottom],10)
                        .background(.orange.opacity(0.1))
                        .cornerRadius(10.0)
                        VStack{
                            Picker(selection: $selectedItem, label: Text("نوع العملية")) {
                                Text("تشغيل").tag(OptionEnum.START_UNIT)
                                Text("ايقاف").tag(OptionEnum.STOP_UINT)
                                Text("تحويل حالة").tag(OptionEnum.CHANGE_UINT)
                            }
                            .padding()
                            .font(.custom(ge_bold.rawValue, size: 16)).bold()
                            .foregroundStyle(Color(red: 0.92, green: 0.35, blue: 0.16))
                            .pickerStyle(.navigationLink)
                        }
                        .frame(width: geometry.size.width * 0.8, height: 40, alignment: .center).padding([.top,.bottom],10)
                        .background(.orange.opacity(0.1))
                        .cornerRadius(10.0)
                        if selectedItem == .STOP_UINT || selectedItem == .CHANGE_UINT {
                            VStack{
                                Picker("التدوير البطيئ", selection: $eventRatching){
                                    Text("في الخدمة").tag("in service")
                                    Text("لا يعمل").tag("not orking")
                                }
                                .padding()
                                .font(.custom(ge_bold.rawValue, size: 16)).bold()
                                .foregroundStyle(Color(red: 0.92, green: 0.35, blue: 0.16))
                                .pickerStyle(.navigationLink)
                            }
                            .frame(width: geometry.size.width * 0.8, height: 40, alignment: .center).padding([.top,.bottom],10)
                            .background(.orange.opacity(0.1))
                            .cornerRadius(10.0)
                        }
                        if selectedItem == .START_UNIT {
                            HStack(spacing:10){
                                HStack{
                                    Text("FSNL")
                                        .font(.system(size:14).bold())
                                        .padding(15)
                                        .background(.orange.opacity(0.1))
                                        .cornerRadius(10.0)
                                        .foregroundStyle(Color(red: 0.92, green: 0.35, blue: 0.16))
                                    TextField("00:00",text: $eventFSNL)
                                        .font(.system(size:14).bold())
                                        .padding(15)
                                        .background(.orange.opacity(0.1))
                                        .cornerRadius(10.0)
                                    
                                }
                                HStack{
                                    Text("SYNC")
                                        .font(.system(size:14).bold())
                                        .padding(15)
                                        .background(.orange.opacity(0.1))
                                        .cornerRadius(10.0)
                                        .foregroundStyle(Color(red: 0.92, green: 0.35, blue: 0.16))
                                    TextField("00:00",text: $eventSynch)
                                        .font(.system(size:14).bold())
                                        .padding(15)
                                        .background(.orange.opacity(0.1))
                                        .cornerRadius(10.0)
                                }
                                
                                
                            }
                            .frame(width: geometry.size.width * 0.8, height: 30, alignment: .center).padding(.top, 20)
                        }
                        VStack{
                            HStack(alignment: .center, spacing:100){
                                Text("التاريخ")
                                    .font(.custom(ge_bold.rawValue, size: 16)).bold()
                                    .foregroundStyle(Color(red: 0.92, green: 0.35, blue: 0.16))
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topTrailing)
                                
                                Text("الوقت")
                                    .font(.custom(ge_bold.rawValue, size: 16)).bold()
                                    .foregroundStyle(Color(red: 0.92, green: 0.35, blue: 0.16))
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topTrailing)
                                
                            }
                            HStack(alignment: .center, spacing:100){
                                DatePicker(
                                    "",
                                    selection: $eventDate,
                                    displayedComponents: [.date]
                                )
                                .datePickerStyle(.compact)
                                .environment(\.locale, .init(identifier: "en"))
                                DatePicker(
                                    "",
                                    selection: $eventTime,
                                    displayedComponents: [.hourAndMinute]
                                    
                                )        .datePickerStyle(.compact)
                                    .environment(\.locale, .init(identifier: "de"))
                            }
                            
                        }
                        .frame(width: geometry.size.width * 0.8, height: 70, alignment: .center).padding(.top, 20)
                        VStack{
                            Text("الحدث")
                                .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topTrailing)
                                .font(.custom(ge_bold.rawValue, size: 16))
                                .foregroundStyle(Color(red: 0.92, green: 0.35, blue: 0.16))
                            TextField(text: $eventText, label: {
                                Text("")
                            })
                            .font(Font.custom("Poppins-Regular", size: 15))
                            .multilineTextAlignment(.center)
                            .frame(width: geometry.size.width * 0.7, height: 30, alignment: .center)
                            .background(
                                Rectangle()
                                    .fill(.orange.opacity(0.1))
                                    .cornerRadius(8)
                                    .frame(width: geometry.size.width * 0.8, height: 40, alignment: .center)
                            )
                        }
                        .frame(width: geometry.size.width * 0.8, height: 70, alignment: .center).padding([.top,.bottom], 10)
                        
                        
                        HStack{
                            Text("Note")
                                .font(.system(size:16).bold())
                                .padding(15)
                                .background(.orange.opacity(0.1))
                                .cornerRadius(10.0)
                                .foregroundStyle(Color(red: 0.92, green: 0.35, blue: 0.16))
                            TextField("Note",text: $eventNote)
                                .font(.system(size:14).bold())
                                .padding(15)
                                .background(.orange.opacity(0.1))
                                .cornerRadius(10.0)
                            
                        }
                        .frame(width: geometry.size.width * 0.8, height: 40, alignment: .center).padding(.top, 20)
                        
                        Button("إرسال حدث جديد", action: createPost)
                            .font(.custom(ge_bold.rawValue, size: 16).weight(.medium))
                            .foregroundColor(.white)
                            .frame(width: 161, height: 50)
                            .background(Color(red: 0.92, green: 0.35, blue: 0.16))
                            .cornerRadius(16)
                            .padding(30)
                    }
                    .frame(alignment: .center)
                }
                .padding(.top, 20)
                .frame(width: geometry.size.width*9/10, height: .infinity, alignment: .center)
                Spacer()
                
            }.navigationBarBackButtonHidden(true)
                .background(Color.white, ignoresSafeAreaEdges: .all)
            
        }
    }
    func createPost(){
        isLoading = true
        showKeyboard = false
        Task{
            do{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let date = dateFormatter.string(from: eventDate)
                if let postImageData {
                    let post = DcsEvents(location: location.rawValue, eventDate: eventDate, eventText: eventText, eventStatus: selectedItem.rawValue, eventTime: eventTime, eventSynch: eventSynch, eventFSNL: eventFSNL, eventRatching: eventRatching, eventNote: eventNote, eventUsername: eventUsername)
                    try await createDocumentAtFirebase(post)
                }else{
                    let post = DcsEvents(location: location.rawValue, eventDate: eventDate, eventText: eventText, eventStatus: selectedItem.rawValue, eventTime: eventTime, eventSynch: eventSynch, eventFSNL: eventFSNL, eventRatching: eventRatching, eventNote: eventNote, eventUsername: eventUsername)
                    
                    try await createDocumentAtFirebase(post)
                }
            } catch {
                await setError(error)
            }
        }
        @Sendable func formatedDate(date: Date) -> String {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
    }
    func createDocumentAtFirebase(_ post: DcsEvents)async throws{
        let doc = Firestore.firestore().collection("Events").document()
        let _ = try doc.setData(from: post,completion: { error in
            if error == nil {
                isLoading = false
                var updatedPost = post
                updatedPost.id = doc.documentID
                //                onPost(updatedPost)
                dismiss()
            }
        })
    }
    func setError(_ error: Error)async{
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

#Preview {
    ContentView()
}
enum OptionEnum :String{
    case START_UNIT = "In Service"
    case STOP_UINT = "Stand By"
    case CHANGE_UINT = "Shutdown"
    case START = "START"
    case STOP = "STOP"
}

enum LocationPath1:String, Equatable, CaseIterable  {
    case GT16 = "GT16"
    case GT19 = "GT19"
    case GT20 = "GT20"
    case GT21 = "GT21"
    case GT22 = "GT22"
    case GT23 = "GT23"
    case GT24 = "GT24"
    case GT25 = "GT25"
    case GT26 = "GT26"
    case GT27 = "GT27"
    case GT28 = "GT28"
    case GT29 = "GT29"
    case GT30 = "GT30"
}
enum LocationFTC:String ,Equatable, CaseIterable  {
    case sk1_1 = "SKID#1 SP#1"
}
enum FUS:String,  Equatable, CaseIterable  {
    case un1 = "FUS#1"
    case un2 = "FUS#2"
}
enum Tanks :String , Equatable, CaseIterable  {
    case tank6 = "Tank#6"
    case tank7 = "Tank#7"
}
//Picker("اختيار الوحدة", selection: $location){
//    ForEach(Array(LocationPath1.allCases), id: \.self) {
//
//        Text($0.rawValue).tag($0.rawValue)
//    }
//
//}
