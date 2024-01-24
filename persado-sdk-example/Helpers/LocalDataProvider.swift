//
//  LocalDataProvider.swift
//  persado-sdk-example
//

import Foundation

enum LocalDataProvider {
    static var products: [ShopProduct] {
        return arrayFromLocalData(of: ShopProduct.self, filename: "products")
    }

    static var customers: [ShopCustomer] {
        return arrayFromLocalData(of: ShopCustomer.self, filename: "customers")
    }

    static func getRecommendedProducts(maxCount: Int, from product: ShopProduct) -> [ShopProduct] {
        return Array(products.filter({ $0.id != product.id }).prefix(maxCount))
    }

    private static func arrayFromLocalData<T: Decodable>(of type: T.Type, filename: String) -> [T] {
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: fileURL),
              let decodedData = try? JSONDecoder().decode([T].self, from: data)
        else {
            return []
        }
        return decodedData
    }
}
