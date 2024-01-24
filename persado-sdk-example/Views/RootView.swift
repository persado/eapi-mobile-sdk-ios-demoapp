//
//  RootView.swift
//  persado-sdk-example
//

import SwiftUI

struct RootView: View {
    @StateObject var flowCoordinator: FlowCoordinator = FlowCoordinator()
    @StateObject var productsViewModel: ProductListViewModel
    @StateObject var personaViewModel: PersonaPickerViewModel

    init() {
        let flowCoordinator = FlowCoordinator()
        _flowCoordinator = StateObject(wrappedValue: flowCoordinator)
        _productsViewModel = StateObject(wrappedValue: ProductListViewModel(flowCoordinator: flowCoordinator))
        _personaViewModel = StateObject(wrappedValue: PersonaPickerViewModel())
    }

    var body: some View {
        ZStack {
            NavigationStack(path: $flowCoordinator.navigationPath) {
                ProductListView(viewModel: productsViewModel)
                    .navigationDestination(for: FlowDestination.self) { destination in
                        buildDestinationView(for: destination)
                    }
            }
            if flowCoordinator.showLoader {
                Color.black.opacity(0.15)
                    .ignoresSafeArea()
                VStack {
                    ProgressView()
                          .progressViewStyle(CircularProgressViewStyle(tint: .white))
                          .controlSize(.large)
                          .padding()
                }
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
        }
        .sheet(isPresented: $productsViewModel.shouldShowPersonaPicker) {
            PersonaPickerView(viewModel: personaViewModel)
                .presentationDragIndicator(.visible)
        }
    }

    @ViewBuilder func buildDestinationView(for destination: FlowDestination) -> some View {
        switch destination {
        case .productDetail(let product):
            ProductDetailsView(
                viewModel: ProductDetailsViewModel(
                    product: product,
                    cartViewModel: productsViewModel.cartViewModel,
                    flowCoordinator: flowCoordinator
                )
            )
        case .cart:
            CartView(viewModel: productsViewModel.cartViewModel)
        case .orderSuccess(let order):
            OrderSuccessfulView(
                viewModel: OrderSuccessViewModel(
                    order: order,
                    cartViewModel: productsViewModel.cartViewModel,
                    flowCoordinator: flowCoordinator
                )
            )
        }
    }
}

#Preview {
    RootView()
}
