//
//  ExpenseRowView.swift
//  CoinTracker
//
//  Created by Jan Klanica on 20.04.2024.
//

import SwiftUI

struct ExpenseRowView: View {
    @ObservedObject var expense: ExpenseModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(expense.Name)
                .font(.headline)
            HStack {
                Text("\(expense.DateOfPayment, formatter: DateFormatter.shortDate)")
                    .foregroundColor(.secondary)
                Spacer()
                Text(expense.TotalPrice, format: .currency(code: "CZK"))
                    .font(.headline)
            }
        }
    }
}
