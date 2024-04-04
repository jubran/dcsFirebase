//
//  Groups4Comp.swift
//  figmaSwift
//
//  Created by جبران on 01/01/2024.
//

import SwiftUI

struct Groups4Comp: View {
    @State private var ge_bold:UIDevice.Fonts = .bold
    @State private var ge_light:UIDevice.Fonts  = .light
    @State private var loading:Bool = false
    var body: some View {
        VStack {
            Text("الوضع الحالي")
                .unredacted()
                .font(.custom(ge_bold.rawValue, size: 25))
                .foregroundColor( Color(red: 0.92, green: 0.35, blue: 0.16))
                .padding()
            HStack{
                ZStack() {
                    Text("الوحدات")
                        .font(.custom(ge_bold.rawValue, size: 15))
                        .foregroundColor(Color(red: 0.22, green: 0.21, blue: 0.18))
                        .offset(x: 0, y: 82)
//                    Text("")
//                        .font(Font.custom("Poppins", size: 16))
//                        .foregroundColor(Color(red: 0.54, green: 0.49, blue: 0.45))
//                        .offset(x: -1, y: 108)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 170, height: 182)
                        .background(Color(red: 0.93, green: 0.95, blue: 0.91))
                        .cornerRadius(28)
                        .offset(x: 0, y: -29)
                }
                .frame(width: 170, height: 240)
                ZStack() {
                    Text("المنقيات")
                        .font(.custom(ge_bold.rawValue, size: 15))
                        .foregroundColor(Color(red: 0.22, green: 0.21, blue: 0.18))
                        .offset(x: -0.50, y: 82)
//                    Text("20 SR")
//                        .font(Font.custom("Poppins", size: 16))
//                        .foregroundColor(Color(red: 0.54, green: 0.49, blue: 0.45))
//                        .offset(x: -1, y: 108)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 170, height: 182)
                        .background(Color(red: 0.93, green: 0.95, blue: 0.91))
                        .cornerRadius(28)
                        .offset(x: 0, y: -29)
                }
                .frame(width: 170, height: 240)
                
            }
            HStack{
                ZStack() {
                    Text("التفريغ")
                        .font(.custom(ge_bold.rawValue, size: 15))
                        .foregroundColor(Color(red: 0.22, green: 0.21, blue: 0.18))
                        .offset(x: 0, y: 82)
//                    Text("21 SR")
//                        .font(Font.custom("Poppins", size: 16))
//                        .foregroundColor(Color(red: 0.54, green: 0.49, blue: 0.45))
//                        .offset(x: -1, y: 108)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 170, height: 182)
                        .background(Color(red: 0.93, green: 0.95, blue: 0.91))
                        .cornerRadius(28)
                        .offset(x: 0, y: -29)
                }
                .frame(width: 170, height: 240)
                ZStack() {
                    Text("الخزانات")
                        .font(.custom(ge_bold.rawValue, size: 15))
                        .foregroundColor(Color(red: 0.22, green: 0.21, blue: 0.18))
                        .offset(x: -0.50, y: 82)
//                    Text("27 SR")
//                        .font(Font.custom("Poppins", size: 16))
//                        .foregroundColor(Color(red: 0.54, green: 0.49, blue: 0.45))
//                        .offset(x: -1, y: 108)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 170, height: 182)
                        .background(Color(red: 0.93, green: 0.95, blue: 0.91))
                        .cornerRadius(28)
                        .offset(x: 0, y: -29)
                }
                .frame(width: 170, height: 240)
                
            }
        }
        .onAppear{StartNetworkCall()}
        .redacted(reason: loading ? .placeholder: [])
        
        
    }
    func StartNetworkCall(){
        loading = true
        DispatchQueue.main.asyncAfter(deadline: .now() /*+ 1*/){
            loading = false
        }
    }
}

#Preview {
    Groups4Comp()
}
