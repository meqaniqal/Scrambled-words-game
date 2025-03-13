//
//  ScoreView.swift
//  Scrambledwordsbegin2
//
//  Created by Sheldon Lawrence on 3/5/25.
//

import SwiftUI


struct ScoreView: View {
    
    let score: Int
    let questionCount:Int
    // get access to .dismiss for the .sheet
    @Environment(\.dismiss) var dismiss  // Environment variable to dismiss the view
        
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            VStack {
                
                Text("Final Score:")
                    .foregroundStyle(.white)
                    .font(.system(size:26,weight:.bold))
                Text("Score:\(score)/\(questionCount)")
                    .foregroundStyle(.white)
                Button(action: {dismiss()}) {
                    Text("Restart Game")
                        .frame(width:150,height:50)
                        .foregroundStyle(.white)
                        .background(Color.blue)
                        .font(.system(size:18,weight:.bold))
                        .cornerRadius(10)
                    
                }
                .padding(.vertical)
                    
            }
        }
    }
}

#Preview {
    ScoreView(score:2,questionCount:3)
}
