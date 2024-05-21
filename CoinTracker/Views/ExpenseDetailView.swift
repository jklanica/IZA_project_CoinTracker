//
//  ExpenseDetailView.swift
//  CoinTracker
//
//  Created by Jan Klanica on 20.04.2024.
//

import SwiftUI
import CoreData

// view for displaying details of an expense
struct ExpenseDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var expense: ExpenseModel

    @State var isEditing: Bool

    var body: some View {
        List {
            // name, date, price
            Group {
                Text(expense.Name)
                    .font(.title)
                    .bold()
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)

                HStack {
                    Text(expense.DateOfPayment, formatter: DateFormatter.longDate)
                    Spacer()
                    Text(expense.TotalPrice, format: .currency(code: "CZK"))
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)

            // expense items
            Section(header:
                Text("Expense Items")
                    .font(.headline)
            ) {
                ForEach(expense.ExpenseItems) { item in
                    ExpenseItemRowView(item: item)
                }
            }

            // editing sheet
            .sheet(isPresented: $isEditing) {
                NavigationView {
                    ExpenseEditView(expense: $expense)
                    .navigationTitle("Edit Expense")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing:
                        Button("Done") {
                            isEditing.toggle()
                        }
                    ).onDisappear {
                        updateExpense()
                    }
                }
            }
        }
        .navigationTitle("Expense Detail")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: editButton)
    }
    
    private var editButton: some View {
        Button(action: {
            isEditing.toggle()
        }) {
            Text("Edit")
        }
    }

    func updateExpense() {
        do {
            // save
            try viewContext.save()
        } catch {
            // display error
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            AppAlert.shared.setAlert(alert: Alert(
                title: Text("Error"),
                message: Text("Could not update Expense"))
            )
        }
    }
}
