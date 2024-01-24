//
//  FlowCoordinator.swift
//  persado-sdk-example
//

import Foundation
import SwiftUI
import UIKit

class FlowCoordinator: ObservableObject {
    @Published var navigationPath: [FlowDestination] = []
    @Published var showLoader: Bool = false

    func pop() {
        navigationPath.removeLast()
    }

    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }

    private func enqueue(value: FlowDestination) {
        navigationPath.append(value)
    }

    func goTo(destination: FlowDestination) {
        enqueue(value: destination)
    }
}

enum FlowDestination: Hashable {
    case productDetail(product: ShopProduct)
    case cart
    case orderSuccess(order: ShopOrder)
}
