//
//  Question.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/23/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import Foundation

class Question: NSObject {
    static let fields = ["module", "question", "answers", "correctIdx"]
    
    @objc var module: Int
    @objc var question: String
    @objc var answers: [String]
    @objc var correctIdx: Int
    
    override init() {
        module = 0
        question = ""
        answers = []
        correctIdx = 0
        super.init()
    }
    
    init(module: Int, question: String, answers: [String], correctIdx: Int) {
        self.module = module
        self.question = question
        self.answers = answers
        self.correctIdx = correctIdx
    }
    
    func shuffleAnswers() {
        let correctAns = answers[correctIdx]
        answers.shuffle()
        correctIdx = answers.firstIndex(of: correctAns)!
    }
}
