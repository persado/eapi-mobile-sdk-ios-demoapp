//
//  PriceRepesentation.swift
//  persado-sdk-example
//

import Foundation

protocol ProductPriceRepesentation {
    var product: ShopProduct { get }
    var productMsrp: String { get }
    var productDiscoutPrice: String { get }
}

extension ProductPriceRepesentation {
    var productMsrp: String {
        return Formatter.currencyFormatter.string(from: NSNumber(value: product.msrp)) ?? ""
    }

    var productDiscoutPrice: String {
        return Formatter.currencyFormatter.string(from: NSNumber(value: product.discountPrice)) ?? ""
    }
}
