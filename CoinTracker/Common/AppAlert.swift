//
//  AppAlert.swift
//  CoinTracker
//
//  Created by Jan Klanica on 24.04.2024.
//

import Foundation
import SwiftUI

class AppAlert: ObservableObject {
    static let shared = AppAlert()

    @Published public var isPresented: Bool
    public var alert: Alert? {
        get { _alert }
    }

    private var _alert: Alert?

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

