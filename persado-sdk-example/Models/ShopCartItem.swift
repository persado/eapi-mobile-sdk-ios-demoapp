//
//  ShopCartItem.swift
//  persado-sdk-example
//

import Foundation

struct ShopCartItem: Identifiable, Hashable {
    var id: UUID
    var product: ShopProduct

    init(product: ShopProduct) {
        id = UUID()
        self.product = product
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
