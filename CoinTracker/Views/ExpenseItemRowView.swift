//
//  ExpenseItemRowView.swift
//  CoinTracker
//
//  Created by Jan Klanica on 20.04.2024.
//

import SwiftUI

// view representing a single expense item in a list
struct ExpenseItemRowView: View {
    @ObservedObject var item: ExpenseItemModel

    var body: some View {
        VStack(alignment: .leading) {
            // name
            Text(item.Name)
                .font(.headline)
                .foregroundColor(.primary)
            // count
            HStack {
                Text("Count:")
                    .foregroundColor(.secondary)
                Spacer()
                Text(String(item.Count))
                    .foregroundColor(.primary)
            }
            // price per unit
            HStack {
                Text("Price Per Unit:")
                    .foregroundColor(.secondary)
                Spacer()
                Text(item.PricePerUnit, format: .currency(code: "CZK"))
                    .foregroundColor(.primary)
            }
        }
    }
}
