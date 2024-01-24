//
//  AddedCartViewModel.swift
//  persado-sdk-example
//

import Foundation

class AddedCartViewModel: ObservableObject {
    @Published var recommendedProducts: [ShopProduct] = []
    var flowCoordinator: FlowCoordinator
    var onGoToRecommended: (ShopProduct) -> ()
    init(addedProduct: ShopProduct, flowCoodinator: FlowCoordinator, onGoToRecommended: @escaping (ShopProduct) -> ()) {
        self.recommendedProducts = LocalDataProvider.getRecommendedProducts(maxCount: 2, from: addedProduct)
        self.flowCoordinator = flowCoodinator
        self.onGoToRecommended = onGoToRecommended
    }

    func goToProduct(_ product: ShopProduct) {
        onGoToRecommended(product)
    }

    func returnToShop() {
        flowCoordinator.popToRoot()
    }

    func goToCart() {
        flowCoordinator.goTo(destination: .cart)
    }
}
