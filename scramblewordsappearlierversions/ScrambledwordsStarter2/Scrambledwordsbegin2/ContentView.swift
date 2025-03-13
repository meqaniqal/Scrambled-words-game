//
//  ContentView.swift
//  Scrambledwordsbegin2
//
//  Created by Sheldon Lawrence on 3/3/25.
//

import SwiftUI

struct ContentView: View {
    @State private var score: Int = 0
    // this is an @State if you want switching out the contents of this variable to trigger a rerunning of everything that uses this variable, such as the ForEach loop for displaying the letters.
    //var letters:[String]=["O","R","A","N","G","E"]
    @State private var wordList:[String]=["APPLE","ORANGE","BANANA"]
    //@State private var wordList:[String]=["apple","orange","banana"]
    @State private var guessedLetters: [String] = []
//    var correctWord:String
//    {
//        return wordList[Int.random(in: 0..<wordList.count)]
//    }
//    @State private var letters: [String] = []
//    init() {
//        let letters = wordList[Int.random(in: 0..<wordList.count)]
//        _letters = State(initialValue: stringToCharacterArray(letters))
//    }
    //
    @State private var correctWord: String=""
    @State private var letters: [String] = []
    @State private var shuffledLetters: [String] = []
    // here we can compute initial values:
    init() {
        let selectedWord = wordList[Int.random(in: 0..<wordList.count)]
        _correctWord = State(initialValue: selectedWord)
        _letters = State(initialValue: stringToCharacterArray(selectedWord))
        _shuffledLetters = State(initialValue: shuffle(word: selectedWord))
    }
    
    var body: some View {
        
        //could name the below variable "geometry" but often, it
        // is named "proxy," so we do that here:
        GeometryReader { proxy in
        
            ZStack {
                Color.background
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        Spacer()
                        Image(correctWord.lowercased())
                            .resizable()
                            .frame(width: 100, height: 100)
                            
                        Spacer()
                           
                        
                        HStack {
                            //display current guess:
                            //\.self gives each letter an identifier so different instances of the same letter are represented by different identifiers (hashes). This id is necessary only because the elements of an array do not conform to identifiable.
                            
                            ForEach(guessedLetters, id: \.self) { letter in
                            VStack {
                                LetterView(character:letter)
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 25, height: 2)
                                
                            }
                        }
                        .padding(.bottom, 20)
                            
                            
                        }
                        
                        
                    }
                    //I must use geometryreader if I want the following frame to be based on the size of the screen being used.
                    //Making a square frame based on the size of 90% of the with of the geometry from geometry reader:
                    .frame(width: proxy.size.width*0.9, height: proxy.size.width*0.9)
                    // this goes over the image
                    // if stroke and no fill, you see the image through the overlay.
                    .overlay{
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.border, lineWidth: 2)
                    }
                    Text("Score: \(score)")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.white)
                        .padding(.top)
                    HStack {
//                        ForEach(shuffledLetters, id: \.self) { letter in
//                            LetterView(character:letter)
//                                .onTapGesture {
//                                    print("tapped \(letter)")
//                                    guessedLetters.append(letter)
//                                }
//                        }
                        //id of \.0 refers to the first pair in the enumeration, which is the index
                        // using \.1 refers to the value, which in the case of duplicate letters, would
                        // result in the index not necessarily corresponding to the correct position in the
                        // shuffled letters array, making some letters remain despite clicking them.
                        ForEach(Array(shuffledLetters.enumerated()), id: \.0){ index,letter in
                            LetterView(character:letter)
                                .onTapGesture {
                                    if shuffledLetters[index] != "" {
                                        
                                    
                                    print("tapped \(letter), index: \(index)")
                                    guessedLetters.append(letter)
                                        print("guessed letters: \(guessedLetters)")
                                        print("correct word: \(stringToCharacterArray(correctWord))")
                                        if guessedLetters==stringToCharacterArray(correctWord.lowercased()){
                                    score+=1
                                    }
                                    shuffledLetters[index] = ""
                                    }
                                }
                        }
                     
                    }
                }
                
            }
        }
        
    }
}
    
#Preview {
    ContentView()
}

struct LetterView: View {
    //@State is only used if this variable is supposed to autoupdate anything in the view when updated. Also, the fact that let specifies a constant does not mean that the constant must be the same for all instances of LetterView.
    // We don't need an intializer, but this definition of character is defined by the default initializer as a required input parameter when instantiating a LetterView via LetterView() above
    let character:String
    // example initializer:
    /*
    init(character: String) {
        self.character = character
    }
    */
    var body: some View {
        Text(character)
            .foregroundStyle(.white)
            .frame(width: 30, height: 30)
            .background(Color.white.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .font(.system(size: 15, weight: .semibold))
    }
}

func stringToCharacterArray(_ word: String) -> [String] {
    return word.map { String($0) }
}

func shuffle(word:String)->[String] {
    var wordArray: [String] = stringToCharacterArray(word)
    
    for i in stride(from: wordArray.count - 1, to: 0, by: -1) {
        let j = Int.random(in: 0...i)
        wordArray.swapAt(i, j)
    }
    return wordArray
}

