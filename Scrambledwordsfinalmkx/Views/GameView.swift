//
//  ContentView.swift
//  Scrambledwordsbegin2
//
//  Created by Sheldon Lawrence on 3/3/25.
//

import SwiftUI

struct GameView: View {
    //@State variables are auto-updated in views when their values change:
    @State private var score: Int = 0
    @State private var guessedLetters: [Letter] = []
    @State private var showSuccess: Bool = false
    @State private var showFailure: Bool = false
    // an array of questions, from QuestionModel, initialized with image names, scrambled word, and unscrambled word
    @State private var questions:[Question]=Question.regenQuestions()
    @State private var currentQuestionIndex: Int = 0
    @State  var showFinalScore: Bool = false
    
    
//    @State private var alertTitle = ""
//    @State private var alertMessage = ""
//    @State private var showAlert: Bool = false

    var body: some View {
        
        GeometryReader { proxy in
            ZStack {
                Color.background
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        Spacer()
                        Image(questions[currentQuestionIndex].image)
                            .resizable()
                            .frame(width: 100, height: 100)
                        Spacer()
                        /* method one, using enumerated to find index:*/
                        //                        HStack {
                        //                            // since I made an id property in LetterModel, id is not required in the ForEach loop:
                        //                            ForEach(Array(guessedLetters.enumerated()), id: \.1) { index,guessedLetter in
                        //                            VStack {
                        //                                LetterView(letter:guessedLetter)
                        //                                Rectangle()
                        //                                    .fill(Color.white)
                        //                                    .frame(width: 25, height: 2)
                        //
                        //                            }
                        //                            .onTapGesture {
                        //                                if !guessedLetter.text.isEmpty {
                        //                                    letters[guessedLetter.id].text = guessedLetter.text
                        //                                    guessedLetters.remove(at:index)
                        //                                }
                        //                            }
                        //                        }
                        //                        .padding(.bottom, 20)
                        //                        }
                        /* method 2, using search for index where id and text are the same as the guessed letter:*/
                        HStack {
                            
                            ForEach(guessedLetters) { guessedLetter in
                                VStack {
                                    LetterView(letter:guessedLetter)
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: 25, height: 2)
                                }
                                .onTapGesture {
                                    //if hashable not set in model, you can search explicitly:
                                    /*
                                     //this is called a "higher order function.":
                                     let index=
                                     guessedLetters.firstIndex{
                                     queryLetter in
                                     queryLetter.id==guessedLetter.id
                                     }
                                     */
                                    // unpack optional of the index of the clicked on letter in guessedLetters.
                                    if let index=guessedLetters.firstIndex(of: guessedLetter){
                                        if !guessedLetter.text.isEmpty {
                                            // put back into the correct index in letters, index found in guessedLetter.id
                                            questions[currentQuestionIndex].scrambledLetters[guessedLetter.id].text = guessedLetter.text
                                            // erase letter from guessedLetters.
                                            guessedLetters.remove(at: index)
                                        }
                                    }
                                }
                            }
                            .padding(.bottom, 20)
                        }
                    }
                    .frame(width: proxy.size.width*0.9, height: proxy.size.width*0.9)
                    .overlay{
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.border, lineWidth: 2)
                    }
                    Text("Score: \(score)")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.white)
                        .padding(.top)
                    HStack {
                        ForEach(Array(questions[currentQuestionIndex].scrambledLetters.enumerated()),id:\.1){index,letter in
                            LetterView(letter:letter)
                                .onTapGesture {
                                    if !letter.text.isEmpty {
                                        guessedLetters.append(letter)
                                        questions[currentQuestionIndex].scrambledLetters[index].text = ""
                                        //all letters have been moved to top, so time to check if the correct arrangement of the word was correct
                                        if guessedLetters.count == questions[currentQuestionIndex].scrambledLetters.count
                                        {
                                            let guessedAnswer = guessedLetters.map { $0.text }.joined()
                                            //                                            var guessedAnswer = ""
                                            //                                            for guessedLetter in guessedLetters {
                                            //                                                guessedAnswer+=guessedLetter.text
                                            //                                                if guessedAnswer==correctAnswer{
                                            //                                                    score+=1
                                            //                                                }
                                            //                                            }
                                            
                                            if guessedAnswer==questions[currentQuestionIndex].answer{
                                                score+=1
                                                showSuccess=true
                                                // timedelay of 1 second before making the "correct" tick mark disappear.
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                                    self.showSuccess=false
                                                    if currentQuestionIndex<questions.count-1{
                                                        currentQuestionIndex+=1
                                                    } else{
                                                        showFinalScore=true
                                                    }
                                                    //currentQuestionIndex=(currentQuestionIndex+1)%questions.count
                                                })
                                                //                                                alertTitle="Correct!"
                                                //                                                alertMessage="You got the right answer."
                                            } else{
                                                showFailure=true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                                    self.showFailure=false
                                                    if currentQuestionIndex<questions.count-1{
                                                        currentQuestionIndex+=1
                                                    } else {
                                                        showFinalScore=true
                                                    }
                                                })
                                                //                                                alertTitle="Incorrect!"
                                                //                                                alertMessage="You got the wrong answer."
                                            }
                                           
                                            guessedLetters.removeAll()
                                            //                                            showAlert=true
                                            
                                        }
                                    }
                                }
                        }
                        
                    }
                }
                //the view includes these displays when guessedLetters is filled, depending on whether the answer is right or wrong.
                //There are two booleans because there are 3 conditions, one of which is "neither"
                if showFailure{
                    VStack{
                        Image("cross")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                    
                }
                if showSuccess{
                    VStack{
                        Image("tick")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                    
                }
                
            }
        }
        //present the ScoreView view modally (sliding up, dismissible by sliding down from top, or clicking the restart game button)
        //notice how .sheet is not presenting all parameters within the parentheses beyond isPresented, but between code blocks (closures). There is no parameter preceding the first codeblock because it is implied as the code to be executed when $showFinalScore becomes false.
        .sheet(isPresented: $showFinalScore) {
            //This is executed when ScoreView is dismissed:
            score=0
            currentQuestionIndex=0
            // reset the questions so they are no longer empty:
            questions=Question.regenQuestions()
        } content: {
            ScoreView(score: score,questionCount: questions.count)
            
        }

        
        /* if we chose to use alert to show right or wrong:*/
//        .alert(alertTitle, isPresented: $showAlert){
//            Button("OK"){
//                
//            }
//        } message: {
//            Text(alertMessage)
//        }
    }
}
    

    
#Preview {
    GameView()
}



