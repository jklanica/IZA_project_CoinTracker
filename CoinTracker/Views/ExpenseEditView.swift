//
//  ExpenseEditView.swift
//  CoinTracker
//
//  Created by Jan Klanica on 20.04.2024.
//

import SwiftUI
import CoreData

// view for editing an expense
struct ExpenseEditView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var expense: ExpenseModel

    @State var selectedExpenseItem: ExpenseItemModel?
    @State var isEditingExpenseItem: Bool = false

    var isTotalPriceDisabled: Bool {
        get {
            return expense.ExpenseItems.count != 0
        }
        set { }
    }

    var body: some View {
        ZStack {
            List {
                // name, price, date
                Group {
                    TextField("Name", text: $expense.Name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)

                    TextField("Total Price", value: $expense.TotalPrice, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .keyboardType(.decimalPad)
                        .disabled(isTotalPriceDisabled)
                        .overlay(
                            HStack {
                                Spacer()
                                Text("CZK")
                                    .padding(.trailing, 10)
                                    .foregroundColor(.secondary)
                            }
                        )

                    DatePicker(selection: $expense.DateOfPayment, displayedComponents: .date) {
                        Text("Select Date")
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)

                // expense items
                Section(header:
                    HStack {
                        Text("Expense Items")
                            .font(.headline)
                        Spacer()
                        Button(action: { addExpenseItem() }) {
                            Image(systemName: "plus")
                        }
                    }
                ) {
                    ForEach(expense.ExpenseItems) { item in
                        Button {
                            selectedExpenseItem = item
                            isEditingExpenseItem.toggle()
                        } label: {
                            ExpenseItemRowView(item: item)
                        }
                    }
                    .onDelete { indexSet in
                        deleteExpenseItem(at: indexSet)
                    }
                }
            }
            // modal for editing expense item
            CenteredModalView(isPresented: $isEditingExpenseItem) {
                if let selectedExpenseItem_ = selectedExpenseItem {
                    ExpenseItemEditView(item: Binding<ExpenseItemModel>(
                        get: { selectedExpenseItem_ },
                        set: { newValue in selectedExpenseItem = newValue }
                    ), isPresented: $isEditingExpenseItem)
                    .onDisappear {
                        updateExpenseItem()
                    }
                }
            }
        }
    }
    
    func updateExpenseItem() {
        do {
            // save
            try viewContext.save()
        } catch {
            // display error
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            AppAlert.shared.setAlert(alert: Alert(
                title: Text("Error"),
                message: Text("Could not update Expense Item"))
            )
        }
    }
    
    func addExpenseItem() {
        // new expense item
        let newExpenseItem = ExpenseItemModel(context: viewContext)

        // set default values
        newExpenseItem.PricePerUnit = 0
        newExpenseItem.Count = 1
        newExpenseItem.Expense = expense
        
        // open detail view for editing
        selectedExpenseItem = newExpenseItem
        isEditingExpenseItem = true
    }

    func deleteExpenseItem(at: IndexSet) {
        let objs = at.map { expense.ExpenseItems[$0] }
        
        // delete all selected expense items
        for expenseItem in objs {
            viewContext.delete(expenseItem)
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
                message: Text("Could not delete Expense Item"))
            )
        }
    }
}
