//
//  ProductDetailsViewModel.swift
//  persado-sdk-example
//

import Foundation

class ProductDetailsViewModel: ObservableObject, ProductPriceRepesentation {
    @Published var product: ShopProduct
    @Published var shouldShowAddedToCart: Bool = false
    var cartViewModel: CartViewModel
    var flowCoordinator: FlowCoordinator

    init(product: ShopProduct, cartViewModel: CartViewModel, flowCoordinator: FlowCoordinator) {
        self.product = product
        self.cartViewModel = cartViewModel
        self.flowCoordinator = flowCoordinator
    }

    func addProductToCart() {
        cartViewModel.addToCart(product)
        shouldShowAddedToCart = true
    }

    func goBack() {
        flowCoordinator.pop()
    }

    var productMsrp: String {
        return Formatter.currencyFormatter.string(from: NSNumber(value: product.msrp)) ?? ""
    }

    var productDiscoutPrice: String {
        return Formatter.currencyFormatter.string(from: NSNumber(value: product.discountPrice)) ?? ""
    }

    deinit {
        print("\(type(of: self)) deinitialized")
    }
}

