//
//  PersonaPickerView.swift
//  persado-sdk-example
//

import SwiftUI

struct PersonaPickerView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: PersonaPickerViewModel

    var body: some View {
        VStack {
            ScrollView {
                Text("SELECT_PERSONA")
                    .customFont(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    .padding(.leading, 12)
                VStack(spacing: 16) {
                    dropDown
                        .border(Color.black, width: 1)
                    attributesSection
                        .padding(.bottom)
                }
                .padding(.horizontal)
            }
        }
        Button(action: {
            dismiss()
        }, label: {
          HStack {
            Spacer()
            Text("DONE")
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

    var dropDown: some View {
        VStack {
            DisclosureGroup(
                isExpanded: $viewModel.isDropDownExpanded,
                content: {
                    ForEach(viewModel.customers) { customer in
                        VStack {
                            Divider()
                                .padding(.vertical, 4)
                            HStack {
                                Group {
                                    Image(systemName: "checkmark")
                                        .opacity(viewModel.selectedCustomer == customer ? 1 : 0)
                                    Text(customer.name)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .foregroundColor(.black)
                            }
                        }
                        .background(Color.white)
                        .onTapGesture {
                            viewModel.selectedCustomer = customer
                            withAnimation {
                                viewModel.isDropDownExpanded = false
                            }
                        }
                    }
                },
                label: {
                    Text(viewModel.selectedCustomer?.name ?? "SELECT_PERSONA")
                        .fontWeight(.semibold)
                }
            )
            .padding()
        }
    }

    @ViewBuilder
    var attributesSection: some View {
        if let selectedCustomer = viewModel.selectedCustomer {
            VStack(spacing: 16) {
                SectionView(title: "DEMOGRAPHIC_TITLE") {
                    InfoRowView(title: "CITY_ATTRIBUTE", value: selectedCustomer.city)
                    InfoRowView(title: "COUNTRY_ATTRIBUTE", value: selectedCustomer.country)
                    InfoRowView(title: "GENDER_ATTRIBUTE", value: selectedCustomer.gender)
                    InfoRowView(title: "MARITAL_STATUS", value: selectedCustomer.maritalStatus)
                }
                SectionView(title: "CUSTOMER_SEGMENT_TITLE") {
                    InfoRowView(title: "LOYALTY_STATUS_ATTRIBUTE", value: selectedCustomer.loyaltyStatus)
                    InfoRowView(title: "ACCOUNT_STATUS_ATTRIBUTE", value: selectedCustomer.accountStatus)
                }
                SectionView(title: "ACCOUNT_TRANSACTIONAL_TITLE") {
                    InfoRowView(title: "CURRENCY_ATTRIBUTE", value: selectedCustomer.currency)
                    InfoRowView(title: "ACCOUNT_ID_ATTRIBUTE", value: selectedCustomer.accountId)
                }
                SectionView(title: "ACCOUNT_TRANSACTIONAL_TITLE") {
                    InfoRowView(title: "DEVICE_TYPE_ATTRIBUTE", value: selectedCustomer.deviceType)
                    InfoRowView(title: "BROWSER_ATTRIBUTE", value: selectedCustomer.browser)
                }
            }
        }
    }
}

#Preview {
    PersonaPickerView(
        viewModel: PersonaPickerViewModel()
    )
}
