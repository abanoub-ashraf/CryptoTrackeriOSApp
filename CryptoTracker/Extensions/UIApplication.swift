//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 19/04/2024.
//

import SwiftUI

///
/// to dismiss the keyboard in SwiftUI
///
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
