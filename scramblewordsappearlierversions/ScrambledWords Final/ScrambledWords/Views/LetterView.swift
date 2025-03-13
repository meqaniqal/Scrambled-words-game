//
//  LetterView.swift
//  ScrambledWords
//
//  Created by Gwinyai Nyatsoka on 19/1/2024.
//

import Foundation
import SwiftUI

struct LetterView: View {
    let letter: Letter
    var body: some View {
        Text(letter.text)
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(Color.white)
            .frame(width: 30, height: 30)
            .background(Color.white.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
