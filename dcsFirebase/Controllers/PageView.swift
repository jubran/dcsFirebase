//
//  PageView.swift
//  figmaSwift
//
//  Created by جبران on 02/01/2024.
//

import SwiftUI

struct PageView: View {
    var page: Page
    @State private var ge_bold:UIDevice.Fonts = .bold
    @State private var ge_light:UIDevice.Fonts  = .light
    var body: some View {
        VStack(spacing: 10) {
            Image("\(page.imageUrl)")
                .resizable()
                               .scaledToFit()
                               .padding()
                               .frame(width: 358, height: 200)
                               .background(.gray.opacity(0.10))
                               .cornerRadius(20)
                               .padding()
            Text(page.name)
                .font(.custom(ge_bold.rawValue, size: 18))
           
                Text(page.description)
                    .font(.custom(ge_light.rawValue, size: 16))
                    .multilineTextAlignment(.center)
                                .frame(width: 300)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(page: Page.samplePage)
    }
}
