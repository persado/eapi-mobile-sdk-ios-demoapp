//
//  CustomFont.swift
//  persado-sdk-example
//

import SwiftUI

struct CustomFont: ViewModifier {

    @Environment(\.sizeCategory) var sizeCategory

    public enum TextStyle {
        case title
        case title2
        case title3
        case title4
        case callout
        case headline
        case subheadline
        case caption
        case caption2
        case body
        case largeSubheadline
    }

    var textStyle: TextStyle

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
       return content.font(.custom(fontName, size: scaledSize))
    }

    private var fontName: String {
        switch textStyle {
        case .title, .title2, .title3, .title4:
            return "AvenirNext-Regular"
        case .callout:
            return "AvenirNext-Regular"
        case .headline:
            return "AvenirNext-Semibold"
        case .subheadline, .largeSubheadline:
            return "AvenirNext-Regular"
        case .caption:
            return "AvenirNext-Regular"
        case .caption2:
            return "AvenirNext-Regular"
        case .body:
            return "AvenirNext-UltraLight"
        }
    }

    private var size: CGFloat {
        switch textStyle {
        case .title:
            return 28
        case .title2:
            return 22
        case .title3:
            return 20
        case .title4:
            return 17
        case .callout:
            return 16
        case .headline:
            return 17
        case .largeSubheadline:
            return 20
        case .subheadline:
            return 15
        case .caption:
            return 12
        case .caption2:
            return 11
        case .body:
            return 17
        }
    }

}

extension View {
    func customFont(_ textStyle: CustomFont.TextStyle) -> some View {
        self.modifier(CustomFont(textStyle: textStyle))
    }
}
