//
//  SectionView.swift
//  persado-sdk-example
//

import SwiftUI

struct SectionView<Content>: View where Content: View {
    let title: LocalizedStringKey
    let content: () -> Content

    init(title: LocalizedStringKey, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .customFont(.title3)
                .fontWeight(.semibold)
            Divider()
                .padding(.top, -8)
            content()
        }
    }

}

#Preview {
    SectionView(title: "Test Section") {
        InfoRowView(title: "Test", value: "Section")
    }
}
