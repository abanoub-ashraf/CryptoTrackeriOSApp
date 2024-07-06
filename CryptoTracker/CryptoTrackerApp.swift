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
        
        loadRocketSimConnect()
    }
    
    private func loadRocketSimConnect() {
		#if DEBUG
            guard (Bundle(path: "/Applications/RocketSim.app/Contents/Frameworks/RocketSimConnectLinker.nocache.framework")?.load() == true) else {
                print("Failed to load linker framework")
                return
            }
            print("RocketSim Connect successfully linked")
		#endif
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
