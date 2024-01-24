//
//  CartRowView.swift
//  persado-sdk-example
//

import SwiftUI

struct CartRowView: View {
    let viewModel: ProductListItemViewModel

    init(product: ShopProduct) {
        self.viewModel = ProductListItemViewModel(product: product)
    }

    var body: some View {
        VStack {
            HStack {
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
                .frame(width: 80, height: 100)
                VStack(alignment: .leading) {
                    Text("\(viewModel.product.category) > \(viewModel.product.itemType)")
                        .customFont(.subheadline)
                        .foregroundStyle(Color.gray)
                    Text(viewModel.product.name)
                        .customFont(.title3)
                        .foregroundStyle(Color.black)
                    Text(viewModel.productMsrp)
                        .customFont(.subheadline)
                        .bold()
                        .foregroundStyle(Color.gray)
                        .strikethrough()
                }
                Spacer()
                Text(viewModel.productDiscoutPrice)
                    .customFont(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.black)
            }
        }
    }
}

#Preview {
    CartRowView(product: LocalDataProvider.products.first!)
}
