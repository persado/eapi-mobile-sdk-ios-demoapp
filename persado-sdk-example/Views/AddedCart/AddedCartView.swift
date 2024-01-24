//
//  AddedCartView.swift
//  persado-sdk-example
//

import SwiftUI

struct AddedCartView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: AddedCartViewModel

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        VStack(spacing: 12) {
            Text("PRODUCT_ADDED")
                .customFont(.title2)
                .fontWeight(.medium)
                .padding(.top)
            VStack(spacing: 16) {
                Text("INTERESTED_ANOTHER")
                    .customFont(.callout)
                    .fontWeight(.light)
                LazyVGrid(columns: columns, spacing: 12) {
                    Section {
                        ForEach(viewModel.recommendedProducts) { product in
                            ProductListItemView(product: product)
                                .onTapGesture {
                                    dismiss()
                                    viewModel.goToProduct(product)
                                }
                        }
                    }
                }
            }
            .padding(12)
            VStack(spacing: 0) {
                Button(action: {
                    viewModel.returnToShop()
                    dismiss()
                }, label: {
                  HStack {
                    Spacer()
                    Text("CONTINUE_SHOPPING")
                          .customFont(.largeSubheadline)
                          .fontWeight(.medium)
                    Spacer()
                  }
                  .padding()
                })
                .contentShape(Rectangle())
                .tint(.black)

                Button(action: {
                    dismiss()
                    viewModel.goToCart()
                }, label: {
                  HStack {
                    Spacer()
                    Text("CHECK_OUT")
                          .customFont(.largeSubheadline)
                          .fontWeight(.medium)
                    Spacer()
                  }
                  .padding()
                })
                .contentShape(Rectangle())
                .background(Color.black)
                .tint(.white)
            }

        }
        .padding(.top)
    }
}

#Preview {
    AddedCartView(
        viewModel: AddedCartViewModel(
            addedProduct: LocalDataProvider.products.first!,
            flowCoodinator: FlowCoordinator(),
            onGoToRecommended: { _ in }
        )
    )
}
