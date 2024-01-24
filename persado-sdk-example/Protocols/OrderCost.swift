//
//  OrderCost.swift
//  persado-sdk-example
//

import Foundation

protocol OrderCost {
    var cartItems: [ShopCartItem] { get }
    var shippingCost: Float { get }
    var subtotal: Float { get }
    var total: Float { get }
}

extension OrderCost {
    var subtotal: Float {
        return cartItems
            .map({$0.product.discountPrice})
            .reduce(0, +)
    }
    var total: Float {
        return subtotal + shippingCost
    }
}
