//
//  ContentView.swift
//  dcsFirebase
//
//  Created by جبران on 13/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab:BottomBarSelectedTab = .plus


    var body: some View {
        
        Header()
         VStack{
             if selectedTab == .home{
                 ScrollView(showsIndicators: false){
                     SlidersSL()
                 }
             }
             
             if selectedTab == .search{
                 ScrollView(showsIndicators: false){
//                     Showdetails()
                     EventList()
                 }
             }
             
             if selectedTab == .plus{
                     shipmentControl()
//                     .padding(.vertical)
                 
             }
             if selectedTab == .notification{
                 ScrollView(showsIndicators: false){
                     Groups4Comp()
                 }
             }
             if selectedTab == .profile{
                 ScrollView(showsIndicators: false){
                   MyProfileView()
//                     ProfileView()
//                         .padding(.top,20)
                 }
                 
             }
             
         }
         
             
             
             
         
         VStack {
             BottomBar(selectedTab: $selectedTab)
                
         }
    }
}

#Preview {
    ContentView()
}
