//
//  HomeStatsView.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 19/04/2024.
//

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

@available(iOS 17.0, *)
#Preview {
    HomeStatsView(showPortfolio: .constant(false))
        .environmentObject(Preview.dev.vm)
}
