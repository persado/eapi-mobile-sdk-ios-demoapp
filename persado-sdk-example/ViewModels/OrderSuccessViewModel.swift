//
//  OrderSuccessViewModel.swift
//  persado-sdk-example
//

import Foundation

class OrderSuccessViewModel: ObservableObject {
    let order: ShopOrder
    var cartViewModel: CartViewModel
    var flowCoordinator: FlowCoordinator

    init(order: ShopOrder, cartViewModel: CartViewModel, flowCoordinator: FlowCoordinator) {
        self.order = order
        self.cartViewModel = cartViewModel
        self.flowCoordinator = flowCoordinator
    }


    func getEstimatedDate() -> String {
        return Formatter.dateFormatter.string(from: order.estDelivery)
    }

    func returnToShop() {
        cartViewModel.emptyCart()
        flowCoordinator.popToRoot()
    }

    func getDiscoutPrice(for itemPrice: Float) -> String {
        return Formatter.currencyFormatter.string(from: NSNumber(value: itemPrice)) ?? ""
    }
}

extension OrderSuccessViewModel: OrderCostRepresentation {
    var cartItems: [ShopCartItem] {
        order.cartItems
    }

    var shippingCost: Float {
        order.shippingCost
    }
}
