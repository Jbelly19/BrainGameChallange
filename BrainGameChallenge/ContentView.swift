//
//  ContentView.swift
//  BrainGameChallenge
//
//  Created by Josh Belmont on 10/9/20.
//

import SwiftUI

struct ContentView: View {
    let TURNS_IN_GAME = 10
    let possibleMoves = ["Rock", "Paper", "Sissors"]
    
    @State private var score = 0;
    @State private var currentMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var alertTitle = ""
    @State private var alertText = ""
    @State private var showingAlert = false
    @State private var turns = 0
    
    func getCorrectResponse() -> Int{
        switch currentMove {
        case 0:
            return shouldWin ? 1 : 2
        case 1:
            return shouldWin ? 2 : 0
        case 2:
            return shouldWin ? 0 : 1
        default:
            return 0
        }
    }
    
    func handleUserMove(_ move:Int){
        let correctResponse = getCorrectResponse()
        if (move == correctResponse){
            alertTitle = "Correct"
            score += 1
            alertText = "Your score is \(score)"
        } else{
            alertTitle = "Wrong"
            if (score > 0){
                score -= 1
            }
            alertText = "The correct answer was \(possibleMoves[correctResponse])"
        }
        
        
        showingAlert = true
        
    }
    
    func nextTurn(){
        currentMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
        turns += 1
        showingAlert = false
    }
    
    func restartGame(){
        currentMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
        turns = 0
        score = 0
    }
    
    
    var body: some View {
        Group{
            if turns == TURNS_IN_GAME {
                Text("Game Over!")
                Text("Score: \(score)")
                Button(action: {
                    self.restartGame()
                }, label: {
                    Text("Restart")
                })
            } else {
                VStack{
                    Text("Computer chose: \(possibleMoves[currentMove])")
                    
                    Text("Make a selection so that you will: \(shouldWin ? "Win" : "Lose" )")
                    HStack{
                        ForEach(0..<3){ number in
                            Button(action: {
                                self.handleUserMove(number)
                            }, label: {
                                Text(possibleMoves[number])
                            })
                        }
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertTitle), message: Text(alertText), dismissButton: .default(Text("Continue")){
                            self.nextTurn()
                        })
                    }
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
