//
//  LogoView.swift
//  figmaSwift
//
//  Created by جبران on 04/01/2024.
//

import SwiftUI

struct LogoView: View {
    let image: Image
    let size: CGFloat
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .cornerRadius(size / 4)
            .overlay(
                Rectangle()
                    .stroke(Color.white, lineWidth:1)
                    .frame(width: size, height: size)
            )
            .shadow(color: Color.white, radius:5)
    }
}
struct TimeBadge: View {
    @Binding var foo:DcsEvents
    var body: some View {
        Text(foo.eventTime.formatted(date:.omitted, time: .shortened))
            .font(.caption2)
            .foregroundColor(.gray)
            .frame(width: 50, height: 50)
            .cornerRadius(50 / 4)
            .overlay(
                Rectangle()
                    .stroke(Color.white, lineWidth:1)
                    .frame(width: 50, height: 50)
            )
            .shadow(color: Color.white, radius:5)
    }
}


