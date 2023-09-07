//
//  SettingsView.swift
//  Edutainment
//
//  Created by Maria Sandu on 06.09.2023.
//

import SwiftUI

struct SettingsView: View {
    @State private var multiplicationTable = 4
    @State private var noOfQuestions = 5
    @State private var qandAArray: [QandA] = []
    @State private var presentGame = false
    
    let questionsOptions = [5, 10, 15, 20]
    
    func generateMultiplicationResults() {
        for _ in 1...noOfQuestions {
            let number1 = Int.random(in: 2...multiplicationTable)
            let number2 = Int.random(in: 2...10)
            let question = "\(number1) x \(number2)"
            let result = number1 * number2
            
            let qandA = QandA(question: question, result: result)
            qandAArray.append(qandA)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.mint, .blue]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Section {
                        Text("Which multiplication tables do you want to practice?")
                            .font(.title)
                            .foregroundColor(.primary)
                        Picker("Number of people", selection: $multiplicationTable) {
                            ForEach(0 ..< 11) {
                                Text("Up to \($0)")
                            }
                        }
                    }
                    
                    Section {
                        Picker("Tip percentage", selection: $noOfQuestions) {
                            ForEach(questionsOptions, id: \.self) {
                                Text($0, format: .number)
                            }
                        }
                        .padding()
                        .pickerStyle(.segmented)
                    } header: {
                        Text("How many questions do you want to be asked?")
                    }
                    
                    Button(action: {
                        generateMultiplicationResults()
                        presentGame = true
                    }, label: {
                            Text("Start")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding()
                                .background(Color.mint)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                    })
                    Image("crayon")
                        .renderingMode(.original)
                        .cornerRadius(30)
                        .shadow(radius: 50)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .navigationTitle("Game set up")
            .navigationDestination(isPresented: $presentGame) {
                GameView(multiplicationTable: multiplicationTable, noOfQuestions: noOfQuestions, qandAArray: qandAArray)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
