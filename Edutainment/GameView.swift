//
//  GameView.swift
//  Edutainment
//
//  Created by Maria Sandu on 06.09.2023.
//

import SwiftUI

struct GameView: View {
     var multiplicationTable: Int
     var noOfQuestions: Int
     var qandAArray: [QandA]

    @State private var showFedback = false
    @State private var questionNumber = 0
    @State private var userAnswer = 0
    @State private var score = 0
    @State private var showScore = false
    @State private var feedbackTitle = ""
    @State private var showFeedback = false


    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.mint, .blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Practice multiplication table up to \(multiplicationTable)")
                    .font(.title.weight(.bold))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding()
                    
                HStack {
                    Image("ask")
                        .renderingMode(.original)
                        .cornerRadius(30)
                        .shadow(radius: 50)
                    Text("What is the correct answer?")
                        .font(.title)
                        .foregroundColor(.primary)
                }
                VStack (spacing: 30) {
                    VStack {
                        Text("\(qandAArray[questionNumber].question)")

                            .font(.title.weight(.heavy))
                            .foregroundColor(.primary)
                        HStack {
                            Text("Your answer:")
                                .foregroundColor(.primary)
                                .font(.title3.weight(.semibold))
                                .padding(10)
                            TextField("Answer", value: $userAnswer, format: .number)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            Button(action: {
                                checkResult()
                            }) {
                                Text("Check")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .padding()
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                            }
                        }
                    }
//                    .onAppear {
//                        print(multiplicationTable)
//                        print(qandAArray[0].question)
//                    }
                }
                Button(action: {
                    presentNextQuestion()
//                    userAnswer = 0
                }) {
                    Text("Next question")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color.mint)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                Text("Your score is: \(score)")
                    .foregroundColor(.primary)
                    .font(.title.bold())
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .alert("You completed the game", isPresented: $showScore) {
            Button("Continue", action: restartGame)
        }
        .alert(feedbackTitle, isPresented: $showFedback) {
            Button("Continue", action: checkResult)
        }
    }
    
    func presentNextQuestion() {
        if questionNumber < (noOfQuestions - 1) {
            if userAnswer == qandAArray[questionNumber].result{
                score += 1
            }
            questionNumber += 1
            userAnswer = 0
        }
        else {
            showScore = true
            
        }
    }
    func restartGame() {
        
    }
    
    func checkResult() {
        if userAnswer == qandAArray[questionNumber].result {
            feedbackTitle = "Correct"
            
        }
        else {
            feedbackTitle = "This is not correct. Try again"
            userAnswer = 0
        }
        showFedback = true
    }
}

struct GameView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        GameView(multiplicationTable: 4, noOfQuestions: 5, qandAArray: [QandA(question: "3 x 7?", result: 21)])
    }
}
