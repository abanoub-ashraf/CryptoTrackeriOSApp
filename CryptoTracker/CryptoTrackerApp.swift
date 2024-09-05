//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 13/04/2024.
//

import SwiftUI

@available(iOS 16.0, *)
@main
struct CryptoTrackerApp: App {
    ///
    /// This works cause HomeViewModel is ObservableObject
    ///
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().tintColor = UIColor(Color.theme.accent)
        UITableView.appearance().backgroundColor = .clear
        
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
            ZStack {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .navigationViewStyle(.stack)
                .environmentObject(vm)
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
