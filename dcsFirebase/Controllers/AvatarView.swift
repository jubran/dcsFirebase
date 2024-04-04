//
//  AvatarView.swift
//  figmaSwift
//
//  Created by جبران on 04/01/2024.
//

import SwiftUI

struct AvatarView: View {
    let image: Image
    let size: CGFloat
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .cornerRadius(size / 2)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth:1)
                    .frame(width: size, height: size)
            )
            .shadow(color: Color.white, radius:5)
    }
}


