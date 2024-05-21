//
//  ExpenseRowView.swift
//  CoinTracker
//
//  Created by Jan Klanica on 20.04.2024.
//

import SwiftUI

// view representing a single expense in a list
struct ExpenseRowView: View {
    @ObservedObject var expense: ExpenseModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // name
            Text(expense.Name)
                .font(.headline)
            HStack {
                // date
                Text("\(expense.DateOfPayment, formatter: DateFormatter.shortDate)")
                    .foregroundColor(.secondary)
                Spacer()
                // price
                Text(expense.TotalPrice, format: .currency(code: "CZK"))
                    .font(.headline)
            }
        }
    }
}
