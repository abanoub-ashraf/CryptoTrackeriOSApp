//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 13/04/2024.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    ///
    /// This works cause HomeViewModel is ObservableObject
    ///
    @StateObject private var vm = HomeViewModel()
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
