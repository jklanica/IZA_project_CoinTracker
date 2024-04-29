//
//  ContentView.swift
//  CoinTracker
//
//  Created by Jan Klanica on 20.04.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ExpenseListView()
                .tabItem() {
                    Image(systemName: "dollarsign.circle")
                    Text("Expenses")
                }
            
            MonthlyExpensesView()
                .tabItem() {
                    Image(systemName: "calendar")
                    Text("Monthly Expenses")
                }
        }
    }
}
