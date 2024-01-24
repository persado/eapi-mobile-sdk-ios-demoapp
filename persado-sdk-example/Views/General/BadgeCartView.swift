//
//  BadgeCartView.swift
//  persado-sdk-example
//

import SwiftUI

struct BadgeCartView: View {
    @State var badgeHeight = 0

    var count: Int

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "cart")
                .resizable()
                .scaledToFit()
                .frame(height: 22)
                .foregroundStyle(Color.black)
            if count > 0 {
                GeometryReader { geo in
                    Text(String(count))
                        .customFont(.caption2)
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(4)
                        .background(
                            Circle().fill(Color.black)
                        )
                        .offset(
                            CGSize(
                                width: (geo.size.width/2) + 4,
                                height: -(geo.size.height/2) + 2
                            )
                        )
                }
            }
        }
    }
}
