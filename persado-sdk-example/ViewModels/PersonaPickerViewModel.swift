//
//  PersonaPickerViewModel.swift
//  persado-sdk-example
//

import Foundation
import Combine

class PersonaPickerViewModel: ObservableObject {
    let customers: [ShopCustomer] = LocalDataProvider.customers
    @Published var selectedCustomer: ShopCustomer? = LocalDataProvider.customers.first
    @Published var isDropDownExpanded: Bool = false
    private var subscriptions = Set<AnyCancellable>()

    init() {
        $selectedCustomer.sink(receiveValue: { [weak self] customer in
            guard let customer else { return }
            self?.setUserAttributes(customer: customer)
        })
        .store(in: &subscriptions)
    }

    private func setUserAttributes(customer: ShopCustomer) {
        PersadoManager.shared.userAttributes = customer.persadoAttributes
        PersadoManager.shared.initializeSdk()
    }
}
