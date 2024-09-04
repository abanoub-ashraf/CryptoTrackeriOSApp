//
//  String.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 04/09/2024.
//

import Foundation

extension String {
    var removingHtmlOccurrences: String {
        self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
