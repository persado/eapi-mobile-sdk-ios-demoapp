//
//  ProductListView.swift
//  persado-sdk-example
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject var viewModel: ProductListViewModel
    @State var isCustomTitleVisible: Bool = true

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                Section(content: {
                    Text("PRODUCTS")
                        .customFont(.title)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onDisappear {
                            isCustomTitleVisible = false
                        }
                        .onAppear {
                            isCustomTitleVisible = true
                        }
                })
                .listRowSeparator(.hidden)
                Section(content: {
                    ForEach(viewModel.products) { product in
                        ProductListItemView(product: product)
                            .onTapGesture {
                                viewModel.goToProduct(product)
                            }
                    }
                }, header: {
                    if let showcaseProduct = viewModel.showcaseProduct {
                        ProductListItemView(product: showcaseProduct)
                            .onTapGesture {
                                viewModel.goToProduct(showcaseProduct)
                            }
                    }
                })
            }
            .padding()
        }
        .clipped()
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.white, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal, content: {
                Text("PRODUCTS")
                    .customFont(.title2)
                    .fontWeight(.semibold)
                    .minimumScaleFactor(0.5)
                    .opacity(isCustomTitleVisible ? 0 : 1)
            })
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.shouldShowPersonaPicker = true
                } label: {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.black)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.goToCart()
                }, label: {
                    BadgeCartView(count: viewModel.cartBadgeNo)
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProductListView(
            viewModel: ProductListViewModel(
                flowCoordinator: FlowCoordinator()
            )
        )
    }
}
