//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 13/04/2024.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
