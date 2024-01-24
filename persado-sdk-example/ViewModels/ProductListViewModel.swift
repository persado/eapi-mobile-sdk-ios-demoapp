//
//  ProductListViewModel.swift
//  persado-sdk-example
//

import Foundation
import Combine

class ProductListViewModel: ObservableObject {
    @Published var showcaseProduct: ShopProduct?
    @Published var products: [ShopProduct] = []
    @Published var shouldShowPersonaPicker: Bool = false
    @Published var cartBadgeNo: Int = .zero
    var flowCoordinator: FlowCoordinator
    var cartViewModel: CartViewModel
    var subscriptions = Set<AnyCancellable>()

    init(flowCoordinator: FlowCoordinator) {
        self.flowCoordinator = flowCoordinator
        self.showcaseProduct = LocalDataProvider.products.first
        if  LocalDataProvider.products.count > 1 {
            self.products = Array(LocalDataProvider.products[1..<LocalDataProvider.products.count])
        }
        self.cartViewModel = CartViewModel(flowCoordinator: flowCoordinator)
        cartViewModel.$cartItems.sink { items in
            self.cartBadgeNo = items.count
        }
        .store(in: &subscriptions)
    }

    func goToProduct(_ product: ShopProduct) {
        flowCoordinator.goTo(destination: .productDetail(product: product))
    }

    func goToCart() {
        flowCoordinator.goTo(destination: .cart)
    }
}
