//
//  Date.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 03/09/2024.
//

import Foundation

extension Date {
    init(coinGeckoString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
        return self.shortFormatter.string(from: self)
    }
}
