//
//  QuestionModel.swift
//  Scrambledwordsbegin2
//
//  Created by Sheldon Lawrence on 3/5/25.
//

import Foundation

struct Question:Hashable {
    let image:String
    var scrambledLetters: [Letter]
    let answer:String
}

//MARK: Generates Questions
extension Question{
    //static because this function will generate for all instances of Question.
    // also enables regenQuestions without having to generate an instance of Question initializing the parameters from the main struct above.
    //ie:
//    let questionInit=Question(image:"orange",scrambledLetters:[
//        Letter(id:0,text:"R"),
//        Letter(id:1,text:"N"),
//        Letter(id:2,text:"A"),
//        Letter(id:3,text:"G"),
//        Letter(id:4,text:"E"),
//        Letter(id:5,text:"O")
//    ],answer:"ORANGE")
//    questionInit.regenQuestions()
    //instead, when defined as static, you can generate an array of questions in only one line directly without instantiating an instance:
    //let question=Question.regenQuestions()

    static func regenQuestions(questionWords: [String] = ["orange","banana","apple"])->[Question] {
        var questionArray:[Question]=[]
        for questionWord in questionWords {
            questionArray.append(Question(image:questionWord,scrambledLetters:self.scrambler(word:questionWord.uppercased()),answer:questionWord.uppercased()))
        
            
        }
        return questionArray
    }
    static func scrambler(word:String)->[Letter] {
        // scramble the letters in a word:
        var letters: [Letter] = []
        for (index, letter) in word.enumerated() {
            letters.append(Letter(id: index, text: String(letter)))
        }
        for i in stride(from: letters.count - 1, to: 0, by: -1) {
            let j = Int.random(in: 0...i)
            letters.swapAt(i, j)
        }
        return letters
        
    }
}
