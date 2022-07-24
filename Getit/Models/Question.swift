//
//  Question.swift
//  Getit
//
//  Created by kaorulego5x on 2022/07/24.
//

import Foundation

enum LearnType: String {
    case phrase_read = "phrase_read"
    case phrase_fill = "phrase_fill"
    case sentence_read = "sentence_read"
}

protocol Learn {
    var index: Int { get }
    var type: LearnType { get }
}

struct PhraseRead: Learn {
    let index: Int
    let type = LearnType.phrase_read
    let phrase: String
    let translation: String
    
    init(index: Int, phrase: String, translation: String){
        self.index = index
        self.phrase = phrase
        self.translation = translation
    }
}

struct PhraseFill: Learn {
    let index: Int
    let type = LearnType.phrase_fill
    let phrase: String
    let translation: String
    let options: [String]
    
    init(index: Int, phrase: String, translation: String, options: [String]){
        self.index = index
        self.phrase = phrase
        self.translation = translation
        self.options = options
    }
}

struct Phrase {
    let phrase: String
    let translation: String
}

struct SentenceRead: Learn {
    let index: Int
    let type = LearnType.sentence_read
    let sentence: String
    let translation: String
    let phrase: Phrase?
    
    init(index: Int, sentence: String, translation: String, phrase: Phrase?){
        self.index = index
        self.sentence = sentence
        self.translation = translation
        self.phrase = phrase
    }
}

struct SentenceFill {
    let id: String
    let sentence: String
    let translation: String
    let phrase: Phrase?
    
    init(id: String, sentence: String, translation: String, phrase: Phrase?){
        self.id = id
        self.sentence = sentence
        self.translation = translation
        self.phrase = phrase
    }
}

