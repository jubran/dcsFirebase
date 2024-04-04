//
//  SlidersSL.swift
//  figmaSwift
//
//  Created by جبران on 01/01/2024.
//

import SwiftUI

struct SlidersSL: View {
    @State private var ge_bold:UIDevice.Fonts = .bold
    @State private var ge_light:UIDevice.Fonts  = .light
    @State private var loading:Bool = false
    var body: some View {
            VStack() {
                HStack (spacing: 15){
                    Text("البحث")
                        .unredacted()
                        .font(.custom(ge_bold.rawValue, size: 30))
                        .foregroundColor( Color(red: 0.92, green: 0.35, blue: 0.16))
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("الكل")
                        .unredacted()
                        .font(.custom(ge_bold.rawValue, size: 16))
                        .foregroundColor(Color(red: 0.38, green: 0.43, blue: 0.46))
                }
                .padding()
                ScrollView(.horizontal){
                    HStack(spacing:35){
                        ZStack() {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 164, height: 220)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .inset(by: 0.50)
                                        .stroke(Color(red: 0.83, green: 0.83, blue: 0.85), lineWidth: 0.50)
                                )
                                .offset(x: 0, y: 0)
                                .opacity(0.90)
                            Ellipse()
                                .foregroundColor(.clear)
                                .frame(width: 129, height: 129)
                                .background(Color(red: 0.93, green: 0.95, blue: 0.91))
                                .offset(x: -0.50, y: -31.50)
                            Text("ارامكس")
                                .font(.custom(ge_bold.rawValue, size: 15))
                                .foregroundColor(Color(red: 0.11, green: 0.15, blue: 0.18))
                                .offset(x: -1, y: 61)
                            Text("20-11-2023")
                                .font(Font.custom("Poppins", size: 14).weight(.medium))
                                .foregroundColor(Color(red: 0.38, green: 0.43, blue: 0.46))
                                .offset(x: -1, y: 85.50)
                        }
                        .frame(width: 164, height: 220)
                        //                .offset(x: -186, y: 24.50)
                        ZStack() {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 164, height: 220)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .inset(by: 0.50)
                                        .stroke(Color(red: 0.83, green: 0.83, blue: 0.85), lineWidth: 0.50)
                                )
                                .offset(x: 0, y: 0)
                            
                            Text("سمسا")
                                .font(.custom(ge_bold.rawValue, size: 15))
                                .foregroundColor(Color(red: 0.22, green: 0.21, blue: 0.18))
                                .offset(x: -1, y: 61)
                            Text("12-10-2023")
                                .font(Font.custom("Poppins", size: 14).weight(.medium))
                                .foregroundColor(Color(red: 0.58, green: 0.57, blue: 0.55))
                                .offset(x: -1, y: 85.50)
                        }
                        .frame(width: 164, height: 220)
                        //                .offset(x: 186, y: 24.50)
                        ZStack() {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 164, height: 220)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .inset(by: 0.50)
                                        .stroke(Color(red: 0.83, green: 0.83, blue: 0.85), lineWidth: 0.50)
                                )
                                .offset(x: 0, y: 0)
                            Ellipse()
                                .foregroundColor(.clear)
                                .frame(width: 129, height: 129)
                                .background(Color(red: 0.93, green: 0.95, blue: 0.91))
                                .offset(x: -0.50, y: -31.50)
                            ZStack() {
                                
                            }
                            .frame(width: 56, height: 56)
                            .offset(x: -1, y: -31)
                            Text("سبل")
                                .font(.custom(ge_bold.rawValue, size: 15))
                                .foregroundColor(Color(red: 0.11, green: 0.15, blue: 0.18))
                                .offset(x: -1, y: 61)
                            Text("01-01-2023")
                                .font(Font.custom("Poppins", size: 14).weight(.medium))
                                .foregroundColor(Color(red: 0.38, green: 0.43, blue: 0.46))
                                .offset(x: -0.50, y: 85.50)
                        }
                        .frame(width: 164, height: 220)
                        //                .offset(x: 0, y: 24.50)
                        ZStack() {
                        }
                        .frame(width: 56, height: 56)
                        //                .offset(x: -183, y: -6.50)
                    }
                    .padding(.vertical,20)
                }
            }
            .padding(.vertical,20)
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
//
#Preview {
    SlidersSL()
}
