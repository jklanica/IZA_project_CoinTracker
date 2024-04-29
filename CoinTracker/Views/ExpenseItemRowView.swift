//
//  ExpenseItemRowView.swift
//  CoinTracker
//
//  Created by Jan Klanica on 20.04.2024.
//

import SwiftUI

struct ExpenseItemRowView: View {
    @ObservedObject var item: ExpenseItemModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.Name)
                .font(.headline)
                .foregroundColor(.primary)
            HStack {
                Text("Count:")
                    .foregroundColor(.secondary)
                Spacer()
                Text(String(item.Count))
                    .foregroundColor(.primary)
            }
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
