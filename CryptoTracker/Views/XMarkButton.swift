//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 20/04/2024.
//

import SwiftUI

struct XMarkButton: View {
    var dismissAction: DismissAction?

    var body: some View {
        Button {
            dismissAction?()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

#Preview {
    XMarkButton()
}
