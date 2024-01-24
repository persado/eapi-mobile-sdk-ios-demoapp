//
//  OrderCostRepresentation.swift
//  persado-sdk-example
//

import Foundation

protocol OrderCostRepresentation: OrderCost {
    var cartItems: [ShopCartItem] { get }
    var shippingCost: Float { get }
    var formattedShippingCost: String { get }
    var formattedSubTotal: String { get }
    var formattedTotal: String { get }
}

extension OrderCostRepresentation {
    var formattedShippingCost: String {
        return Formatter.currencyFormatter.string(from: NSNumber(value: shippingCost)) ?? ""
    }

    var formattedSubTotal: String {
        return Formatter.currencyFormatter.string(from: NSNumber(value: subtotal)) ?? ""
    }

    var formattedTotal: String {
        return Formatter.currencyFormatter.string(from: NSNumber(value: total)) ?? ""
    }

}
