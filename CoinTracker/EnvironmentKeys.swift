//
//  EnvironmentKeys.swift
//  CoinTracker
//
//  Created by Jan Klanica on 24.04.2024.
//

import Foundation
import SwiftUI

private struct appAlertEnvKey: EnvironmentKey {
    static let defaultValue: AppAlert = AppAlert.shared
}

extension EnvironmentValues {
    var appAlert: AppAlert {
        get { self[appAlertEnvKey.self] }
        set { self[appAlertEnvKey.self] = newValue }
    }
}
