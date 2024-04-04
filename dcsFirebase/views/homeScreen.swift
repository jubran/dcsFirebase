//
//  shipmentControl.swift
//  figmaSwift
//
//  Created by جبران on 02/01/2024.
//

import SwiftUI

struct shipmentControl: View {
    @State private var pageIndex = 2
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    @State private var ge_bold:UIDevice.Fonts = .bold
    @State private var ge_light:UIDevice.Fonts  = .light
    @State var addEvent = false
    var body: some View {
        TabView(selection: $pageIndex) {
            
            ForEach(pages) { page in
                VStack {
                    Spacer()
                    PageView(page: page)
                    Spacer()
                    if page == pages.last {
                        Button("اضافة حدث", action: addEventToggle)
                            .font(.custom(ge_bold.rawValue, size: 16).weight(.medium))
                            .foregroundColor(.white)
                            .frame(width: 161, height: 50)
                            .background(Color(red: 0.92, green: 0.35, blue: 0.16))
                            .cornerRadius(16)
                        
                    }
                    if page != pages.first && page != pages.last  {
                        Button("اولويات التشغيل", action: incrementPage)
                            .font(.custom(ge_bold.rawValue, size: 16).weight(.medium))
                            .foregroundColor(.white)
                            .frame(width: 161, height: 50)
                            .background(Color(red: 0.92, green: 0.35, blue: 0.16))
                            .cornerRadius(16)
                    }
                    if page == pages.first {
                        Button("إضافة ملاحظة", action: incrementPage)
                            .font(.custom(ge_bold.rawValue, size: 16).weight(.medium))
                            .foregroundColor(.white)
                            .frame(width: 161, height: 50)
                            .background(Color(red: 0.92, green: 0.35, blue: 0.16))
                            .cornerRadius(16)
                    }
                    Spacer()
                }
                .tag(page.tag)
            }
        }
        .animation(.easeInOut, value: pageIndex)// 2
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            dotAppearance.currentPageIndicatorTintColor = .orange
            dotAppearance.pageIndicatorTintColor = .orange.withAlphaComponent(0.3)
        }
        .sheet(isPresented: $addEvent){
            AddEvent(location: .GT30, eventDate: .now, eventText: "", eventStatus: "", eventTime: .now, eventFSNL: "", eventSynch: "", eventRatching: "", eventNote: "", eventUsername: "", ge_bold: $ge_bold)
                .presentationDetents([.height(620), .large])
                       .presentationDragIndicator(.automatic)
        }
        
    }
    
    
    func incrementPage() {
        pageIndex += 1
    }
    
    func goToZero() {
        pageIndex = 0
    }
    func addEventToggle(){
        addEvent.toggle()
    }
}

#Preview {
    shipmentControl()
}
