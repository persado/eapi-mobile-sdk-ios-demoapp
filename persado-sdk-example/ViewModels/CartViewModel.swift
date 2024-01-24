//
//  CartViewModel.swift
//  persado-sdk-example
//

import Foundation

class CartViewModel: ObservableObject {
    @Published var cartItems: [ShopCartItem] = []
    let shippingCost: Float = 25
    var flowCoordinator: FlowCoordinator
    @Published var headLineText: String = NSLocalizedString("SHOPPING_CART", comment: "")
    @Published var totalText: String = NSLocalizedString("TOTAL", comment: "")
    @Published var ctaText: String = NSLocalizedString("COMPLETE_PURCHASE", comment: "")

    init(cartItems: [ShopCartItem] = [], flowCoordinator: FlowCoordinator) {
        self.cartItems = cartItems
        self.flowCoordinator = flowCoordinator
    }

    func addToCart(_ product: ShopProduct) {
        cartItems.append(ShopCartItem(product: product))
    }

    func removeFromCart(_ cartItem: ShopCartItem) {
        cartItems.removeAll(where: { $0.id == cartItem.id })
    }

    func emptyCart() {
        cartItems.removeAll()
    }

    func viewAppear() {
        getTextContent()
        PersadoManager.shared.trackCartView()
    }

    func completePurchase() {
        PersadoManager.shared.trackCompleteClick()
        flowCoordinator.showLoader = true
        let estDate = Calendar.current.date(byAdding: .day, value: 5, to: Date()) ?? Date()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self else { return }
            PersadoManager.shared.trackConversion()
            self.flowCoordinator.showLoader = false
            let order = ShopOrder(estDelivery: estDate, shippingCost: self.shippingCost, cartItems: self.cartItems)
            self.flowCoordinator.goTo(destination: .orderSuccess(order: order))
        }
    }

    func goBack() {
        flowCoordinator.pop()
    }

    private func getTextContent() {
        let cartTextContent = PersadoManager.shared.getCartContent()
        if let headline = cartTextContent?.headline {
            headLineText = headline
        }
        if let total = cartTextContent?.total {
            totalText = total
        }
        if let cta = cartTextContent?.cta {
            ctaText = cta
        }
    }

}

extension CartViewModel: OrderCostRepresentation {}
