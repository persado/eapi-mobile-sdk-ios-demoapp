//
//  ShopOrder.swift
//  persado-sdk-example
//

import Foundation

struct ShopOrder: Identifiable, Hashable {
    let id: UUID = UUID()
    let orderNo: Int = Int.random(in: 1234..<9999)
    let estDelivery: Date
    let shippingCost: Float
    let cartItems: [ShopCartItem]
}

extension ShopOrder: OrderCost {}
