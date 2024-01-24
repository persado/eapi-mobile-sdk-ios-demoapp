//
//  ProductListItemViewModel.swift
//  persado-sdk-example
//

import Foundation

class ProductListItemViewModel: ProductPriceRepesentation {
    let product: ShopProduct

    init(product: ShopProduct) {
        self.product = product
    }
}
