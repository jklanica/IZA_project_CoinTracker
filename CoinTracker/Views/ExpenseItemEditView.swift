//
//  ExpenseItemEditView.swift
//  CoinTracker
//
//  Created by Jan Klanica on 20.04.2024.
//

import SwiftUI

// view for editing an expense item
struct ExpenseItemEditView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var item: ExpenseItemModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // name
                VStack(alignment: .leading) {
                    Text("Name")
                    TextField("Name", text: $item.Name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                }
                
                // count
                VStack(alignment: .leading) {
                    Text("Count")
                    TextField("Count", value: $item.Count, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .keyboardType(.numberPad)
                }
                
                // price per unit
                VStack(alignment: .leading) {
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
                Spacer()
                .navigationBarItems(trailing:
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Close")
                    })
                )
            }
            .padding(10)
        }
    }
}
