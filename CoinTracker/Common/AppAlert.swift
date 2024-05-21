//
//  AppAlert.swift
//  CoinTracker
//
//  Created by Jan Klanica on 24.04.2024.
//

import Foundation
import SwiftUI

// AppAlert is a singleton class that is used to show alerts in the app
class AppAlert: ObservableObject {
    static let shared = AppAlert()

    @Published public var isPresented: Bool
    public var alert: Alert? {
        get { _alert }
    }

    private var _alert: Alert?

    // use nil to dismiss the alert, use Alert to show the alert
    public func setAlert(alert: Alert?) {
        if (alert == nil) {
            isPresented = false
            self._alert = alert
        } else {
            self._alert = alert
            isPresented = true
        }
    }

    private init() {
        isPresented = false
        _alert = nil
    }
}

