//
//  Question.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/23/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import Foundation

class Question: NSObject {
    static let fields = ["question", "answers", "correctIdx"]
    
    var question: String
    var answers: [String]
    var correctIdx: Int
    
    override init() {
        question = ""
        answers = []
        correctIdx = 0
        super.init()
    }
    
    init(question: String, answers: [String], correctIdx: Int) {
        self.question = question
        self.answers = answers
        self.correctIdx = correctIdx
    }
    
    init(data: [String]){
        var temp = data
        self.question = temp.remove(at: 0)
        self.answers = temp
        self.correctIdx = 0
    }
    
    func shuffleAnswers() {
        let correctAns = answers[correctIdx]
        answers.shuffle()
        correctIdx = answers.firstIndex(of: correctAns)!
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "question": question,
            "answers": answers,
            "correctIdx": correctIdx
        ]
    }
}
