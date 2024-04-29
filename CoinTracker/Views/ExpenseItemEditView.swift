//
//  ExpenseItemEditView.swift
//  CoinTracker
//
//  Created by Jan Klanica on 20.04.2024.
//

import SwiftUI

struct ExpenseItemEditView: View {
    @Binding var item: ExpenseItemModel
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            HStack {
                Text("Name")
                TextField("Name", text: $item.Name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
            }

            HStack {
                Text("Count")
                TextField("Count", value: $item.Count, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .keyboardType(.numberPad)
            }

            HStack {
                Text("Price Per Unit")
                TextField("Price Per Unit", value: $item.PricePerUnit, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .keyboardType(.decimalPad)
                    .overlay(
                        HStack {
                            Spacer()
                            Text("CZK")
                                .padding(.trailing, 10)
                                .foregroundColor(.secondary)
                        }
                    )
            }

            HStack {
                Spacer()
                Button(action: {
                    isPresented = false
                }, label: {
                    Text("Save")
                })
                Spacer()
            }
        }
        .padding(10)
    }
}
