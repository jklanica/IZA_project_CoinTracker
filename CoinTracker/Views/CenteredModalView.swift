//
//  CenteredModalView.swift
//  CoinTracker
//
//  Created by Jan Klanica on 20.04.2024.
//

import SwiftUI

// container for modal centered in the middle of the screen
struct CenteredModalView<Content: View>: View {
    @Binding var isPresented: Bool

    var content: () -> Content
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self._isPresented = isPresented
        self.content = content
    }
    
    var body: some View {
        if isPresented {
            ZStack( alignment: .center ) {
                VStack ( alignment: .center ) {
                    Spacer()
                    
                    content()
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(10)
                        .shadow(radius: 8)
                        
                    Spacer()
                }
            }
            .padding(20)
            .background(Color(UIColor.systemBackground).opacity(0.6).ignoresSafeArea())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .transition(.opacity)
        }
    }
}
