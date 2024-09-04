//
//  StatisticView.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 19/04/2024.
//

import SwiftUI

struct StatisticView: View {
    let stat: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(.degrees((stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                    .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
                
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .opacity(stat.percentageChange == nil ? 0 : 1)
        }
    }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    StatisticView(stat: Preview.dev.stat1)
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    StatisticView(stat: Preview.dev.stat2)
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    StatisticView(stat: Preview.dev.stat3)
}
