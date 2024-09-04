//
//  ChartView.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 01/09/2024.
//

import SwiftUI

struct ChartView: View {
    @State private var percentage: CGFloat = 0
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    
    init(coin: CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        self.maxY = self.data.max() ?? 0
        self.minY = self.data.min() ?? 0
        
        let priceChange = (self.data.last ?? 0) - (self.data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        self.endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        self.startingDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60)
    }
    
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yAxis = self.maxY - self.minY
                    let yPosition = (1 - CGFloat((data[index] - self.minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: self.percentage)
            .stroke(self.lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40)
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabels: some View {
        HStack {
            Text(self.startingDate.asShortDateString())
            Spacer()
            Text(self.endingDate.asShortDateString())
        }
    }
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(alignment: .leading) {
                    chartYAxis
                        .padding(.horizontal, 4)
                }
            
            chartDateLabels
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    self.percentage = 1
                }
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    ChartView(coin: Preview.dev.coin)
}
