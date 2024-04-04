//
//  Showdetails.swift
//  figmaSwift
//
//  Created by جبران on 01/01/2024.
//

import SwiftUI
import SwiftData

struct Showdetails: View {
    @State private var ge_bold:UIDevice.Fonts = .bold
    @State private var ge_light:UIDevice.Fonts  = .light
    @State private var search:String = ""
    @State private var loading:Bool = false
    
    var todoItems:[ToDoItem] = [
        ToDoItem(name: "Aramx", priorityNum: "done", isComplete: false),
        ToDoItem(name: "Smsa", priorityNum: "no", isComplete: false),
        ToDoItem(name: "Aramx", priorityNum: "no", isComplete: false),
        ToDoItem(name: "Zajel", priorityNum: "no", isComplete: false),
        ToDoItem(name: "DHL", priorityNum: "no", isComplete: false),
        ToDoItem(name: "Smsa", priorityNum: "no", isComplete: false),
        ToDoItem(name: "Aramx", priorityNum: "no", isComplete: false)
    ]
    
//    @Query(sort: \ToDoItem.name , order: .reverse) var appState:[ToDoItem]
    @State private var searchText = ""
    var body: some View {
        VStack{
            SearchBar(text: $searchText)
                .padding(.top, -30)
            
            ForEach(todoItems.filter({ searchText.isEmpty  ? true : $0.name.localizedCaseInsensitiveContains(searchText) })) {  item in
                Shipment(appState: item)
            }
        }
        .searchable(text: $searchText)
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

struct NoData:View {
    var body: some View {
        ZStack{
            Text("no Data")
        }
    }
}
#Preview {
    Showdetails()
}
struct Shipment: View {
    var appState:ToDoItem
    var body: some View {
        HStack(spacing:.minimum(40,40)){
            VStack{
                LogoView(image: Image("aramx"), size: 50)
            }
            VStack(alignment:.leading){
                Text(appState.name)
                Text("Abha To Jazan")
                    .font(.callout)
                    .foregroundStyle(Color.gray)
                    .lineLimit(1)
            }
            VStack(alignment:.trailing){
                Text("01 Jan 2024")
                Text(appState.priorityNum)
            }
            
        }
        .padding(10)
        .background(Color(red: 0.95, green: 0.94, blue: 0.98))
        .cornerRadius(10)
       
    }
}

struct SearchBar: View {
   
    @Binding var text: String
    @State private var isEditing = false
    var body: some View {
        HStack {
            TextField("Search By Carere...", text: $text)
                .frame(height: 40)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.text = ""
                                
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 15)
                .padding(.vertical,10)
                .onTapGesture {
                    self.isEditing = true
                }
               
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(Animation.default, value: 1)
            }
        }
        .padding(.top,55)
       
    }
    
}
