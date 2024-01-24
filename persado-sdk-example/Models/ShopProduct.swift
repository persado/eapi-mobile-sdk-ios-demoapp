//
//  ShopProduct.swift
//  persado-sdk-example
//

import Foundation

struct ShopProduct: Codable {
    let id: String
    let name: String
    let description: String
    let discountPrice: Float
    let msrp: Float
    let rating: Float
    let itemType: String
    let category: String
    let imageUrl: URL
}

extension ShopProduct: Hashable, Identifiable {}
