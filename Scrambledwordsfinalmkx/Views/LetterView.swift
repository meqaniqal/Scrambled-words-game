//
//  LetterView.swift
//  Scrambledwordsbegin2
//
//  Created by Sheldon Lawrence on 3/5/25.
//

import Foundation
import SwiftUI

struct LetterView: View {
    let letter:Letter
    var body: some View {
        Text(letter.text)
            .foregroundStyle(.white)
            .frame(width: 30, height: 30)
            .background(Color.white.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .font(.system(size: 15, weight: .semibold))
    }
}
