////
////  EditEvent.swift
////  dcsFirebase
////
////  Created by جبران on 13/01/2024.
////
//
////
////  AddEvent.swift
////  dcsFirebase
////
////  Created by جبران on 13/01/2024.
////
//
//import SwiftUI
//
//struct AddEvent1: View {
//    @State var  location:String = ""
//    @State var date:Date = Date()
//    var body: some View {
//        GeometryReader{ geometry in
//            NavigationStack{
//                ZStack{
//                    HStack{
//                        Button{
//                        }label: {
//                            Text("sd")
//                        }
//                        .padding(.leading, 10)
//                        Spacer()
//                    }
//                    
//                }.padding(.top, 10)
//                    .frame(width: geometry.size.width, height: 30, alignment: .center)
//                ZStack{
//                    Rectangle()
//                        .fill(Color.white).opacity(0.3)
//                        .cornerRadius(16)
//                    VStack(spacing: 5){
//                        VStack{
//                            Picker("اختيار الوحدة", selection: $location){
//                                Text("GT16").tag("GT16")
//                                Text("GT19").tag("GT19")
//                                Text("GT20").tag("GT20")
//                            }
//                            .pickerStyle(.navigationLink)
//                        }
//                        .frame(width: geometry.size.width * 0.8, height: 50, alignment: .center).padding(.top, 20)
//                        VStack{
//                            
//                                Picker("الحالة", selection: $location){
//                                    Text("In Service").tag("In Service")
//                                    Text("Stand By").tag("Stand By")
//                                    Text("Shutdown").tag("Shutdown")
//                                }.pickerStyle(SegmentedPickerStyle())
//                        }
//                        .frame(width: geometry.size.width * 0.8, height: 0, alignment: .center).padding(.top, 20)
//                        VStack{
//                            HStack(alignment: .center, spacing:100){
//                                Text("التاريخ")
//                                    .multilineTextAlignment(.center)
//                                    .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topTrailing)
//
//                                Text("الوقت")
//                                    .multilineTextAlignment(.center)
//                                    .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topTrailing)
//
//                            }
//                            HStack(alignment: .center, spacing:100){
//                                DatePicker(
//                                    "",
//                                    selection: $date,
//                                    displayedComponents: [.date]
//                                )
//                                DatePicker(
//                                    "",
//                                    selection: $date,
//                                    displayedComponents: [.hourAndMinute]
//                                    
//                                )        .datePickerStyle(.compact)
//                                    .environment(\.locale, .init(identifier: "de"))
//                            }
//                           
//                        }
//                        .frame(width: geometry.size.width * 0.8, height: 70, alignment: .center).padding(.top, 20)
//                        VStack{
//                            Text("الحدث")
//                                .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topTrailing)
//                            TextField(text:  $location, label: {
//                                Text("الحدث")
//                            })
//                            .font(Font.custom("Poppins-Regular", size: 15))
//                            .multilineTextAlignment(.center)
//                            .frame(width: geometry.size.width * 0.7, height: 30, alignment: .center)
//                            .background(
//                                Rectangle()
//                                    .fill(Color.init(.sRGB, red: 240/255, green: 246/255, blue:255/255, opacity: 1))
//                                    .cornerRadius(8)
//                                    .frame(width: geometry.size.width * 0.8, height: 40, alignment: .center)
//                            )
//                        }
//                        .frame(width: geometry.size.width * 0.8, height: 70, alignment: .center).padding(.top, 10)
//
//                        VStack(){
//                            
//                                Picker("Ratching System", selection:  $location){
//                                    Text("Ratching In Service").tag("Ratching In Service")
//                                    Text("Ratching Not Working").tag("Ratching Not Working")
//                                }.pickerStyle(SegmentedPickerStyle())
//                        }
//                        .frame(width: geometry.size.width * 0.8, height: 30, alignment: .center).padding(.top, 20)
//
//                        HStack(spacing:10){
//                            HStack{
//                                Text("FSNL")
//                                    .font(.system(size:14).bold())
//                                    .padding(15)
//                                    .background(.orange.opacity(0.1))
//                                    .cornerRadius(10.0)
//                                    .foregroundStyle(.orange)
//                                TextField("00:00",text:  $location)
//                                    .font(.system(size:14).bold())
//                                    .padding(15)
//                                    .background(.orange.opacity(0.1))
//                                    .cornerRadius(10.0)
//                                    
//                            }
//                            HStack{
//                                Text("SYNC")
//                                    .font(.system(size:14).bold())
//                                    .padding(15)
//                                    .background(.orange.opacity(0.1))
//                                    .cornerRadius(10.0)
//                                    .foregroundStyle(.orange)
//                                TextField("00:00",text:  $location)
//                                    .font(.system(size:14).bold())
//                                    .padding(15)
//                                    .background(.orange.opacity(0.1))
//                                    .cornerRadius(10.0)
//                            }
//                            
//                            
//                        }
//                        .frame(width: geometry.size.width * 0.8, height: 30, alignment: .center).padding(.top, 20)
//                        HStack{
//                            Text("Note")
//                                .font(.system(size:16).bold())
//                                .padding(15)
//                                .background(Color.init(.sRGB, red: 240/255, green: 246/255, blue:255/255, opacity: 1))
//                                .cornerRadius(10.0)
//                                .foregroundStyle(.orange)
//                            TextField("Note",text: $location)
//                                .font(.system(size:14).bold())
//                                .padding(15)
//                                .background(.orange.opacity(0.1))
//                                .cornerRadius(10.0)
//                            
//                        }
//                        .frame(width: geometry.size.width * 0.8, height: 40, alignment: .center).padding(.top, 20)
//
//                    }
//                    .frame(alignment: .center)
//                }
//                .padding(.top, 40)
//                .frame(width: geometry.size.width*9/10, height: 550, alignment: .center)
//                Spacer()
//                
//            }.navigationBarBackButtonHidden(true)
//                .background(Color.white, ignoresSafeAreaEdges: .all)
//        }
//    }
//}
//#Preview {
//    AddEvent1()
//}
//
