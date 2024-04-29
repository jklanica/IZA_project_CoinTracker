//
//  ExpenseListView.swift
//  CoinTracker
//
//  Created by Jan Klanica on 20.04.2024.
//

import SwiftUI
import CoreData

struct ExpenseListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.appAlert) private var appAlert
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpenseModel.date, ascending: true)],
        animation: .default)
    private var expenses: FetchedResults<ExpenseModel>

    @State private var selectedExpense: ExpenseModel?
    @State private var addingExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses, id: \.self) { expense in
                    Button(action: {
                        addingExpense = false
                        selectedExpense = expense
                    }) {
                        ExpenseRowView(expense: expense)
                            .buttonStyle(PlainButtonStyle())
                    }
                }.onDelete { indexSet in
                    deleteExpense(at: indexSet)
                }
            }
            .navigationTitle("All Expenses")
            .navigationBarItems(trailing: addButton)
            .background(
                NavigationLink(
                    destination: selectedExpense.map { (selectedExpense_: ExpenseModel) -> ExpenseDetailView in
                        return ExpenseDetailView(
                            expense: Binding<ExpenseModel>(
                                get: { selectedExpense_ },
                                set: {newValue in selectedExpense = newValue}
                            ),
                            isEditing: addingExpense
                        )
                    },
                    isActive: Binding<Bool>(
                        get: { selectedExpense != nil },
                        set: { newValue in
                            if (!newValue) {
                                selectedExpense = nil
                            }
                        }
                    )
                ) { EmptyView() }
                .hidden()
            )
        }
    }
        
    private var addButton: some View {
        Button(action: {
            let newExpense = addExpense()
            addingExpense = true
            selectedExpense = newExpense
        }) {
            Image(systemName: "plus")
        }
    }

    func addExpense() -> ExpenseModel {
        let newExpense = ExpenseModel(context: viewContext)

        newExpense.TotalPrice = 0
        newExpense.DateOfPayment = Date()
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            AppAlert.shared.setAlert(alert: Alert(
                title: Text("Error"),
                message: Text("Could not save new Expense"))
            )
        }

        return newExpense
    }

    func deleteExpense(at: IndexSet) {
        let objs = at.map { expenses[$0] }
        
        for expense in objs {
            viewContext.delete(expense)
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            AppAlert.shared.setAlert(alert: Alert(
                title: Text("Error"),
                message: Text("Could not delete Expense"))
            )
        }
    }
}
