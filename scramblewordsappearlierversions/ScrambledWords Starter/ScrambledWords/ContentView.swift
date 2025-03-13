//
//  ContentView.swift
//  ScrambledWords
//

import SwiftUI

struct ContentView: View {
    @State private var pictures: [String]=["apple","banana","orange"]
    @State private var score: Int = 0
    @State private var wordLength: Int = 0
    @State private var currentWord: String = ""
    @State private var currentGuess: String = ""
    var randomPicture:String {
        return pictures[Int.random(in: 0..<pictures.count)]
    }
    
    
    var body: some View {
        
        GeometryReader {proxy in
            ZStack {
                Color.background
                    .ignoresSafeArea()
                VStack {
                    VStack //( spacing:30)
                    {
                        Spacer()
                        Image(String(currentWord))
                            .resizable()
                            .frame(width: 100, height: 100)
                            //.padding(.top,100)
                        Spacer()
                        HStack {
                            
                            ForEach(Array(arrayLiteral: currentGuess), id: \.self) {letter in
                                    VStack {
                                        LetterView(character: letter)
                                            
                                        Rectangle()
                                            .fill(Color.white)
                                            .frame(width: 25, height: 3)
                                            .opacity(0.3)
                                            }
                                    }
                        }
                        .padding(.bottom,20)
                      
                    }
                    .frame(width: proxy.size.width*0.9, height: proxy.size.width*0.9)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.border, lineWidth: 2)
                    }
                    Text("Score: \(score)")
                        .foregroundStyle(Color.white)
                        .font(.system(size:15))
                        .padding()
                   
                    HStack{
                        ForEach(Array(scramble(word: currentWord)), id: \.self) { letter in
                            //Text(String(letter))
                            LetterView(character:String(letter))
                                .onTapGesture {
                                    currentGuess = currentGuess + String(letter)
                                    //currentGuess.append(letter) // Append letter to current guess
                                    print("Tapped: \(letter)"
                        )}
                        }
                    }
                }
            }
            .onAppear {currentWord = randomPicture}
        }  // Set currentWord when the view appears
    }
}
    
func scramble(word: String) -> String {
    var characters: [Character] = Array(word)
    for index in stride(from: characters.count - 1, to: 0, by: -1) {
        let randomIndex = Int.random(in: 0...index)
        characters.swapAt(index, randomIndex)
    }
    return String(characters)
}

func prepareWordForForEach(word: String) -> String {
    let characters: [Character] = Array(word)
    return String(characters)
}



struct LetterView: View {
    let character:String
    var body: some View {
        Text(character)
            .font(.title)
            .foregroundStyle(Color.white)
            .padding()
            .background(Color.white.opacity(0.4))
            .cornerRadius(10)
            
    }
}
    




#Preview {
    ContentView()
}

