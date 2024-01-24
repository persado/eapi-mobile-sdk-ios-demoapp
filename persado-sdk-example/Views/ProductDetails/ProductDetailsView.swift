//
//  ProductDetailsView.swift
//  persado-sdk-example
//

import SwiftUI

struct ProductDetailsView: View {
    @StateObject var viewModel: ProductDetailsViewModel
    @State var detentHeight: CGFloat = 200

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
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
                        .frame(height: 380)
                        VStack(alignment: .leading, spacing: 12) {
                            VStack(alignment: .leading) {
                                Text(viewModel.product.name)
                                    .customFont(.title2)
                                    .foregroundStyle(Color.black)
                                    .lineLimit(1)
                                Text("\(viewModel.product.category) > \(viewModel.product.itemType)")
                                    .customFont(.subheadline)
                                    .foregroundStyle(Color.gray)
                            }
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    RatingsView(value: viewModel.product.rating)
                                        .customFont(.subheadline)
                                    HStack(spacing: 4) {
                                        Text(viewModel.productMsrp)
                                            .customFont(.largeSubheadline)
                                            .bold()
                                            .foregroundStyle(Color.gray)
                                            .strikethrough()
                                        Text(viewModel.productDiscoutPrice)
                                            .customFont(.largeSubheadline)
                                            .bold()
                                            .foregroundStyle(Color.black)
                                    }
                                    .padding(.bottom, 4)
                                }
                            }
                            RoundedRectangle(cornerRadius: 4, style: .circular)
                                .frame(height: 1)
                                .opacity(0.10)
                            Text(viewModel.product.description)
                                .customFont(.body)
                                .fontWeight(.light)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 32)
                    }
                    .background(Color.white)
                }
                Button(action: {
                    viewModel.addProductToCart()
                }, label: {
                    HStack {
                        Spacer()
                        Text("ADD_CART")
                            .customFont(.largeSubheadline)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding()
                })
                .contentShape(Rectangle())
                .background(Color.black)
                .tint(.white)
            }
            .ignoresSafeArea(edges: .top)
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.goBack()
                } label: {
                    Image(systemName: "chevron.backward.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.black,
                            Color.white.opacity(0.75)
                        )
                }

            }
        }
        .sheet(isPresented: $viewModel.shouldShowAddedToCart, content: {
            AddedCartView(
                viewModel: AddedCartViewModel(
                    addedProduct: viewModel.product,
                    flowCoodinator: viewModel.flowCoordinator,
                    onGoToRecommended: { recommendedProduct in
                        viewModel.product = recommendedProduct
                    }
                )
            )
            .readHeight()
            .onPreferenceChange(HeightPreferenceKey.self) { height in
                if let height {
                    self.detentHeight = height
                }
            }
            .presentationDetents([.height(self.detentHeight)])
            .presentationDragIndicator(.visible)
        })
    }
}

#Preview {
    ProductDetailsView(
        viewModel: ProductDetailsViewModel(
            product: LocalDataProvider.products.first!,
            cartViewModel: CartViewModel(
                flowCoordinator: FlowCoordinator()
            ),
            flowCoordinator: FlowCoordinator()
        )
    )
}
