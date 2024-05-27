//
//  ExpenseListView.swift
//  CoinTracker
//
//  Created by Jan Klanica on 20.04.2024.
//

import SwiftUI
import CoreData

// view showing a list of all expenses
struct ExpenseListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpenseModel.date, ascending: false)],
        animation: .default)
    private var expenses: FetchedResults<ExpenseModel>

    @State private var selectedExpense: ExpenseModel?
    
    var body: some View {
        NavigationView {
            // all expenses
            List {
                ForEach(expenses, id: \.self) { expense in
                    Button(action: {
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
                // hidden navigation link so that the expense detail view can be opened and a list item doesn't have a link style
                NavigationLink(
                    destination: selectedExpense.map { (selectedExpense_: ExpenseModel) -> ExpenseEditView in
                        return ExpenseEditView(
                           expense: Binding<ExpenseModel>(
                                get: { selectedExpense_ },
                                set: { newValue in selectedExpense = newValue }
                            )
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
            selectedExpense = newExpense
        }) {
            Image(systemName: "plus")
        }
    }

    func addExpense() -> ExpenseModel {
        // create new expense
        let newExpense = ExpenseModel(context: viewContext)

        // set default values
        newExpense.TotalPrice = 0
        newExpense.DateOfPayment = Date()
        
        do {
            // save
            try viewContext.save()
        } catch {
            // display error
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
        
        // delete all selected expense items
        for expense in objs {
            viewContext.delete(expense)
        }

        do {
            // save
            try viewContext.save()
        } catch {
            // display error
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            AppAlert.shared.setAlert(alert: Alert(
                title: Text("Error"),
                message: Text("Could not delete Expense"))
            )
        }
    }
}
