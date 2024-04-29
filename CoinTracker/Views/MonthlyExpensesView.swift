//
//  MonthlyExpensesView.swift
//  CoinTracker
//
//  Created by Jan Klanica on 25.04.2024.
//

import Foundation
import SwiftUI
import CoreData

struct MonthlyExpensesView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpenseModel.date, ascending: false)],
        animation: .default)
    private var expenses: FetchedResults<ExpenseModel>

    // expenses grouped by year and month
    @State var allExpensesGrouped: [YearExpenses] = []

    // groups expenses by year and month
    private func groupExpenses() {
        var allExpensesGrouped_: [YearExpenses] = []
        for expenseModel in expenses {
            let year = Calendar.current.dateComponents([.year], from: expenseModel.DateOfPayment).year!
            let monthInt = Calendar.current.dateComponents([.month], from: expenseModel.DateOfPayment).month!
            
            let month = Month.intToMonth(num: monthInt)
            
            // new year
            if (allExpensesGrouped_.count == 0 || allExpensesGrouped_[allExpensesGrouped_.count-1].year != year) {
                let yearExpenses = YearExpenses(year: year, monthExpenses: [MonthExpense(month: month, totalExpense: expenseModel.TotalPrice)])
                allExpensesGrouped_.append(yearExpenses)
                continue
            }
            
            // already existing month in already existing year
            var found = false
            for (i, monthExpense) in allExpensesGrouped_[allExpensesGrouped_.count-1].monthExpenses.enumerated() {
                if (monthExpense.month == month) {
                    var yearExpenses = allExpensesGrouped_[allExpensesGrouped_.count-1]
                    yearExpenses.monthExpenses[i].totalExpense += expenseModel.TotalPrice
                    allExpensesGrouped_[allExpensesGrouped_.count-1] = yearExpenses
                    found = true
                    break
                }
            }
            if found {
                continue
            }
            
            // new month in already exisitng year
            let monthExpense = MonthExpense(month: month, totalExpense: expenseModel.TotalPrice)
            var yearExpenses = allExpensesGrouped_[allExpensesGrouped_.count-1]
            yearExpenses.monthExpenses.append(monthExpense)
            allExpensesGrouped_[allExpensesGrouped_.count-1] = yearExpenses
        }
        
        // trigger update and update
        allExpensesGrouped = []
        allExpensesGrouped = allExpensesGrouped_
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(allExpensesGrouped, id: \.self) { yearExpenses in
                    Section (header:
                        Text(String(yearExpenses.year))
                            .font(.headline)
                    ) {
                        ForEach(yearExpenses.monthExpenses, id: \.self) { monthExpense in
                            HStack {
                                Text(monthExpense.month.toString())
                                Spacer()
                                Text(monthExpense.totalExpense, format: .currency(code: "CZK"))
                            }
                        }
                    }
                }
            }
            .navigationTitle(Text("Monthly Expenses"))
        }
        .onAppear() {
            groupExpenses()
        }
    }
}

struct YearExpenses: Hashable {
    var year: Int
    var monthExpenses: [MonthExpense]
    
    static func == (lhs: YearExpenses, rhs: YearExpenses) -> Bool {
        lhs.year == rhs.year
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(year)
    }
}

struct MonthExpense: Hashable {
    var month: Month
    var totalExpense: Double
    
    static func == (lhs: MonthExpense, rhs: MonthExpense) -> Bool {
        lhs.month == rhs.month
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(month)
    }
}

enum Month {
    case Jan
    case Feb
    case Apr
    case Mar
    case May
    case Jun
    case Jul
    case Aug
    case Sep
    case Oct
    case Nov
    case Dec
}

extension Month {
    static func intToMonth(num: Int) -> Month {
        switch num {
        case 1:
            return .Jan
        case 2:
            return .Feb
        case 3:
            return .Mar
        case 4:
            return .Apr
        case 5:
            return .May
        case 6:
            return .Jun
        case 7:
            return .Jul
        case 8:
            return .Aug
        case 9:
            return .Sep
        case 10:
            return .Oct
        case 11:
            return .Nov
        case 12:
            return .Dec
        default:
            return .Jan
        }
    }
    
    func toString() -> String {
        switch self {
        case .Jan:
            return "January"
        case .Feb:
            return "February"
        case .Mar:
            return "March"
        case .Apr:
            return "April"
        case .May:
            return "May"
        case .Jun:
            return "June"
        case .Jul:
            return "July"
        case .Aug:
            return "August"
        case .Sep:
            return "September"
        case .Oct:
            return "October"
        case .Nov:
            return "November"
        case .Dec:
            return "December"
        }
    }
}
