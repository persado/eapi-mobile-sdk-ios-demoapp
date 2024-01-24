//
//  ShopCustomer.swift
//  persado-sdk-example
//

import Foundation

struct ShopCustomer: Codable {
    let name: String
    let city: String
    let country: String
    let gender: String
    let maritalStatus: String
    let loyaltyStatus: String
    let accountStatus: String
    let currency: String
    let accountId: String
    let deviceType: String
    let browser: String
}

extension ShopCustomer: Hashable, Identifiable {
    var id: String { accountId }
}

extension ShopCustomer {
    var persadoAttributes: [String: String] {
        return [
            "location": city,
            "country": country,
            "gender": gender,
            "marital_status": maritalStatus,
            "loyalty_status": loyaltyStatus,
            "account_status": accountStatus,
            "currency": currency,
            "account_id": accountId,
            "device_type": deviceType,
            "browser": browser
        ]
    }
}
