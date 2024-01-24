//
//  InfoRowView.swift
//  persado-sdk-example
//

import SwiftUI

struct InfoRowView: View {
    let title: LocalizedStringKey
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .bold()
                .customFont(.callout)
            Text(value)
                .customFont(.callout)
            Spacer()
        }
    }
}

#Preview {
    InfoRowView(title: "Test", value: "Test")
}
