//
//  RatingsView.swift
//  persado-sdk-example
//

import SwiftUI

struct RatingsView: View {
    let value: Float

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<5) { index in
                Image(systemName: imageName(for: index, value: value))
            }
        }
        .foregroundColor(.black)
    }

    func imageName(for starIndex: Int, value: Float) -> String {
        switch value - Float(starIndex) {
        case ..<0.5:
            return "star"
        case 0.5..<1.0:
            return "star.leadinghalf.filled"
        default:
            return "star.fill"
        }
    }
}
