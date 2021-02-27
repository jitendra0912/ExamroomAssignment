//
//  Question.swift
//  ExamroomAssignment
//
//  Created by Capgemini on 25/02/21.
//

import Foundation
struct  Question {
    
    //struct properties
    var question : String
    var answer : String
    
    //method to initialize the struct
    init(q : String, a : String) {
        self.question = q
        self.answer = a
    }
    
    //getter methods
    func getQuestion() -> String {
        return self.question
    }
    
    func getAnswer() -> String {
        return self.question
    }
}
