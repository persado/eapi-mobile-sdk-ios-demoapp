//
//  CartView.swift
//  persado-sdk-example
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: CartViewModel
    @State var isCustomTitleVisible: Bool = true

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.cartItems.isEmpty {
                emptyCartView
            } else {
                cartList
                totalsView
            }
        }
        .onAppear {
            viewModel.viewAppear()
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.white, for: .navigationBar)
        .toolbar {
            if !viewModel.cartItems.isEmpty {
                ToolbarItem(placement: .principal, content: {
                    Text(viewModel.headLineText)
                        .customFont(.title2)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.5)
                        .opacity(isCustomTitleVisible ? 0 : 1)
                })
            }
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
                            Color.white,
                            Color.black
                        )
                }
            }
        }
    }

    var cartList: some View {
        List {
            Section {
                Text(viewModel.headLineText)
                    .customFont(.title)
                    .fontWeight(.semibold)
                    .onDisappear {
                        isCustomTitleVisible = false
                    }
                    .onAppear {
                        isCustomTitleVisible = true
                    }
            }
            .listRowSeparator(.hidden)
            .padding(.top, 4)
            Section {
                ForEach(viewModel.cartItems) { item in
                    CartRowView(product: item.product)
                        .padding(.vertical, 8)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button("", systemImage: "xmark") {
                                withAnimation {
                                    viewModel.removeFromCart(item)
                                }
                            }
                        }
                }
            }
        }
        .listStyle(.plain)
        .clipped()
    }

    var emptyCartView: some View {
        VStack {
            Image(systemName: "cart")
                .resizable()
                .scaledToFit()
                .frame(width: 75, height: 75)
                .foregroundStyle(Color.gray)
            Text("CART_EMPTY")
                .customFont(.largeSubheadline)
                .padding(.bottom, 75)
        }
    }

    var totalsView: some View {
        VStack {
            VStack {
                HStack {
                    Text("SUBTOTAL")
                        .customFont(.callout)
                        .fontWeight(.medium)
                    Spacer()
                    Text(viewModel.formattedSubTotal)
                        .customFont(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)

                }
                HStack {
                    Text("SHIPPING")
                        .customFont(.callout)
                        .fontWeight(.medium)
                    Spacer()
                    Text(viewModel.formattedShippingCost)
                        .customFont(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)

                }
                HStack {
                    Text(viewModel.totalText)
                        .customFont(.title3)
                        .bold()
                    Spacer()
                    Text(viewModel.formattedTotal)
                        .customFont(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.black)
                }
                .padding(.top, 2)
            }
            .padding()
            Button(action: {
                viewModel.completePurchase()
            }, label: {
                HStack {
                    Spacer()
                    Text(viewModel.ctaText)
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
        .background(
            UnevenRoundedRectangle(
                topLeadingRadius: 12,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 12,
                style: .continuous
            )
            .fill(Color.white)
            .shadow(radius: 5)
        )
    }
}

#Preview {
    return (
        NavigationStack {
            CartView(
                viewModel: CartViewModel(
                    cartItems: LocalDataProvider.products.map({ShopCartItem(product: $0)}),
                    flowCoordinator: FlowCoordinator()
                )
            )
        })
}
