//
//  StatisticModel.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 19/04/2024.
//

import Foundation

struct StatisticModel {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}

extension StatisticModel: Identifiable { }
