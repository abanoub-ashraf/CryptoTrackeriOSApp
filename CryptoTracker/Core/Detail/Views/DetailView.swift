//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 12/07/2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct DetailView: View {
    @StateObject private var vm: DetailViewModel
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private var spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    private var overViewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overViewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.overViewStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })
    }
    
    private var additionalDetailsTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalDetailsGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })
    }
    
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                   
                VStack(spacing: 20) {
                    overViewTitle
                    
                    Divider()
                    
                    overViewGrid
                    
                    additionalDetailsTitle
                    
                    Divider()
                    
                    additionalDetailsGrid
                }
                .padding()
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    NavigationView {
        DetailView(coin: Preview.dev.coin)
            .preferredColorScheme(.light)
    }
}
