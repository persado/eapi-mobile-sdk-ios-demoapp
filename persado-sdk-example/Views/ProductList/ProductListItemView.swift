//
//  ProductListItemView.swift
//  persado-sdk-example
//

import SwiftUI

struct ProductListItemView: View {
    var viewModel: ProductListItemViewModel

    init(product: ShopProduct) {
        self.viewModel = ProductListItemViewModel(product: product)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Color.clear.overlay(
                AsyncImage(url: viewModel.product.imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                }
            )
            .clipShape(Rectangle())
            .frame(height: 180)
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading) {
                    Text(viewModel.product.name)
                        .customFont(.title4)
                        .foregroundStyle(Color.black)
                        .lineLimit(1)
                    Text("\(viewModel.product.category) > \(viewModel.product.itemType)")
                        .customFont(.caption)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundStyle(Color.gray)
                }
                VStack(alignment: .leading, spacing: 4) {
                    RatingsView(value: viewModel.product.rating)
                        .customFont(.caption)
                    HStack(spacing: 4) {
                        Text(viewModel.productMsrp)
                            .customFont(.subheadline)
                            .bold()
                            .foregroundStyle(Color.gray)
                            .strikethrough()
                        Text(viewModel.productDiscoutPrice)
                            .customFont(.subheadline)
                            .bold()
                            .foregroundStyle(Color.black)
                    }
                    .padding(.bottom, 4)
                }
            }
            .padding(.horizontal, 8)
        }
        .background(Color.white)
    }
}

#Preview {
    ProductListItemView(product: LocalDataProvider.products.first!)
}
