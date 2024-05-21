//
//  ExpenseItemModel+CoreDataProperties.swift
//  CoinTracker
//
//  Created by Jan Klanica on 20.04.2024.
//
//

import Foundation
import CoreData


extension ExpenseItemModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseItemModel> {
        return NSFetchRequest<ExpenseItemModel>(entityName: "ExpenseItemModel")
    }

    @NSManaged public var name: String?
    @NSManaged public var count: Int16
    @NSManaged public var pricePerUnit: NSDecimalNumber?
    @NSManaged public var expense: ExpenseModel?
}

// add safe getters and setters to unify access to the model across the app
extension ExpenseItemModel {
    var Name: String {
        get {
            return name ?? "Unknown"
        }
        set(newValue) {
            name = newValue
        }
    }

    var Count: Int16 {
        get {
            return count
        }
        set(newValue) {
            count = newValue
        }
    }

    var PricePerUnit: Double {
        get {
            return pricePerUnit?.doubleValue ?? 0
        }
        set(newValue) {
            pricePerUnit = NSDecimalNumber(value: newValue)
        }
    }

    var Expense: ExpenseModel? {
        get {
            return expense
        }
        set(newValue) {
            if (newValue == nil) {
                return
            }

            newValue?.addToExpenseItems(self)
        }
    }
}

extension ExpenseItemModel : Identifiable {

}
