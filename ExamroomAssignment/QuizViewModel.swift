//
//  QuizViewModel.swift
//  ExamroomAssignment
//
//  Created by Capgemini on 25/02/21.
//
import UIKit
import Foundation
struct QuizViewModel {
    
    var questionNumber : Int = 0
    var score : Int = 0

    //You can set you quesstion or get question from server.
    let questions = [
        Question(q: "A slug's blood is green.", a: "True"),
        Question(q: "Approximately one quarter of human bones are in the feet.", a: "True"),
        Question(q: "The total surface area of two human lungs is approximately 70 square metres.", a: "True"),
        Question(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: "True"),
        Question(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: "False"),
        Question(q: "It is illegal to pee in the Ocean in Portugal.", a: "True"),
        Question(q: "You can lead a cow down stairs but not up stairs.", a: "False"),
        Question(q: "Google was originally called 'Backrub'.", a: "True"),
        Question(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: "True"),
        Question(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: "False"),
        Question(q: "No piece of square dry paper can be folded in half more than 7 times.", a: "False"),
        Question(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", a: "True")
    ]
    
    //getter methods
    mutating func getAnswer(_ selectedAnswer : String) -> Bool{
        let questionAnswer = questions[questionNumber].answer
        if selectedAnswer == questionAnswer{
            score += 1
            return true
        }else{
            return false
        }
    }
    
    func getQuestion() -> String {
        return questions[questionNumber].question
    }
    
    func getProgress() -> Float{
        return Float(questionNumber + 1) / Float(questions.count)
    }
    
    
    mutating func getNextQuestion(){
        if questionNumber + 1 < questions.count{
            questionNumber += 1
        }else{
            questionNumber = 0
            score = 0
        }
    }
    
    func getScore() -> Int{
        return score
    }
    
    
}
 
