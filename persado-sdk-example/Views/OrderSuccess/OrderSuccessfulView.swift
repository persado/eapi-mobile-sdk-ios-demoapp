//
//  OrderSuccessfulView.swift
//  persado-sdk-example
//

import SwiftUI

struct OrderSuccessfulView: View {
    @StateObject var viewModel: OrderSuccessViewModel

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Section {
                        VStack {
                            ZStack(alignment: .topTrailing) {
                                Image(systemName: "cart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 75, height: 75)
                                    .foregroundStyle(Color.gray)
                                Image(systemName: "checkmark.circle.fill")
                                    .symbolRenderingMode(.palette)
                                    .resizable()
                                    .bold()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(
                                        Color.white,
                                        Color("SuccessGreen")
                                    )
                                    .offset(CGSize(width: 12.5, height: 0))
                            }
                            Text("ORDER_SUCCESS")
                                .customFont(.largeSubheadline)
                            HStack {
                                Text("EST_DELIVERY")
                                    .customFont(.subheadline)
                                    .bold()
                                Text(viewModel.getEstimatedDate())
                                    .customFont(.subheadline)
                            }
                        }
                        .padding(.vertical, 22)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(verbatim: "Order #\(viewModel.order.orderNo)")
                            .customFont(.title3)
                            .fontWeight(.semibold)
                        Rectangle()
                            .frame(height: 1)
                            .opacity(0.5)
                        LazyVStack(spacing: 8) {
                            ForEach(viewModel.order.cartItems) { item in
                                HStack {
                                    Text(item.product.name)
                                        .customFont(.callout)
                                        .fontWeight(.medium)
                                    Spacer()
                                    Text(viewModel.getDiscoutPrice(for: item.product.discountPrice))
                                        .customFont(.callout)

                                }
                            }
                        }
                        .padding(.top, 8)
                    }
                    Divider()
                        .padding(.top)
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
                            Text("TOTAL")
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
                }
                .toolbar(.hidden, for: .navigationBar)
            }
            .padding()
            Button(action: {
                viewModel.returnToShop()
            }, label: {
              HStack {
                Spacer()
                Text("GO_BACK")
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
    }
}

#Preview {
    OrderSuccessfulView(
        viewModel: OrderSuccessViewModel(
            order: ShopOrder(
                estDelivery: Date(),
                shippingCost: 25,
                cartItems: LocalDataProvider.products.map({ShopCartItem(product: $0)})
            ),
            cartViewModel: CartViewModel(
                flowCoordinator: FlowCoordinator()
            ),
            flowCoordinator: FlowCoordinator()
        )
    )
}
