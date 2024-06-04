//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Shing Huey on 03/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var resetQuestion = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreTotal = 0
    @State private var questionCount = 0
    
    
    func flagTapped(_ number: Int) {
        
        //        if questionCount == 8 {
        //            resetQuestion = true
        //        }
        //        else{
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreTotal += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        showingScore = true
        questionCount += 1
        //        }
        
        print(questionCount)
    }
    
    func askQuestion(){
        if questionCount == 8 {
            resetQuestion = true
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
        
    }
    
    func reset(){
        questionCount = 0
        scoreTotal = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack{
            RadialGradient(stops:
                            [
                                .init(color: Color(red: 0.71, green: 0.92, blue: 0.84), location: 0.3),
                                .init(color: Color(red: 1.0, green: 0.71, blue: 0.76), location: 0.3)
                            ],
                           center: .top,startRadius: 200,endRadius: 400).ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag").font(.largeTitle.weight(.bold)).foregroundColor(.white)
                
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of").font(.subheadline.weight(.heavy)).foregroundStyle(.secondary)
                        Text(countries[correctAnswer]).font(.largeTitle.weight(.semibold)).foregroundStyle(.black)
                    }
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number]).clipShape(.capsule).shadow(radius:5)
                        }}
                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(scoreTotal)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }.padding()
            
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scoreTotal)")
        }
        .alert("Game Over", isPresented: $resetQuestion) {
            Button("Reset", action: reset)
        } message: {
            Text("Your final score is \(scoreTotal) out of 8")
        }
    }
    
    
}

#Preview {
    ContentView()
}
