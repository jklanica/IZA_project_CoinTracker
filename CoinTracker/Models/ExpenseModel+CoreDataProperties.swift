//
//  ExpenseModel+CoreDataProperties.swift
//  CoinTracker
//
//  Created by Jan Klanica on 20.04.2024.
//
//

import Foundation
import CoreData


extension ExpenseModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseModel> {
        return NSFetchRequest<ExpenseModel>(entityName: "ExpenseModel")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var totalPrice: NSDecimalNumber?
    @NSManaged public var expenseItems: NSSet?
}

// add safe getters and setters to unify access to the model across the app
extension ExpenseModel {
    var Name: String {
        get {
            return name ?? "Unknown"
        }
        set(newValue) {
            name = newValue
        }
    }

    var TotalPrice: Double {
        get {
            if (ExpenseItems.isEmpty) {
                return totalPrice?.doubleValue ?? 0
            }

            return ExpenseItems.reduce(0) { $0 + Double($1.Count) * $1.PricePerUnit }
        }
        set(newValue) {
            totalPrice = NSDecimalNumber(value: newValue)
        }
    }

    var DateOfPayment: Date {
        get {
            return date ?? Date()
        }
        set(newValue) {
            date = newValue
        }
    }

    var ExpenseItems: [ExpenseItemModel] {
        get {
            return expenseItems?.allObjects as? [ExpenseItemModel] ?? []
        }
    }
}

// MARK: Generated accessors for expenseItems
extension ExpenseModel {

    @objc(addExpenseItemsObject:)
    @NSManaged public func addToExpenseItems(_ value: ExpenseItemModel)

    @objc(removeExpenseItemsObject:)
    @NSManaged public func removeFromExpenseItems(_ value: ExpenseItemModel)

    @objc(addExpenseItems:)
    @NSManaged public func addToExpenseItems(_ values: NSSet)

    @objc(removeExpenseItems:)
    @NSManaged public func removeFromExpenseItems(_ values: NSSet)
}

extension ExpenseModel : Identifiable {

}
