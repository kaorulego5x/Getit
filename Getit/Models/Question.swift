//
//  Question.swift
//  Getit
//
//  Created by kaorulego5x on 2022/07/24.
//

import Foundation

enum LearnType: String, Codable {
    case single = "single"
    case idiom = "idiom"
    case practical = "practical"
}

struct LearnPerWord: Codable {
    let word: String
    let learnType: LearnType
}

struct LearnPath: Codable {
    let path: [LearnPerWord]
}

struct Learn: Codable {
    let index: Int
    let word: String
    let phraseReads: [PhraseRead]
    let phraseFills: [PhraseFill]
    let sentenceReads: [SentenceRead]
    let learnType: LearnType
    
    init(index: Int, word: String, phraseReads: [PhraseRead], phraseFills: [PhraseFill], sentenceReads: [SentenceRead], learnType: LearnType) {
        self.index = index
        self.word = word
        self.phraseReads = phraseReads
        self.phraseFills = phraseFills
        self.sentenceReads = sentenceReads
        self.learnType = learnType
    }
}

struct PhraseRead: Codable {
    let index: Int
    let phrase: String
    let translation: String
    
    init(index: Int, phrase: String, translation: String){
        self.index = index
        self.phrase = phrase
        self.translation = translation
    }
}

struct PhraseFill: Codable {
    let index: Int
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

struct Phrase: Codable {
    let phrase: String
    let translation: String
    
    init(phrase: String, translation: String) {
        self.phrase = phrase
        self.translation = translation
    }
}

struct SentenceRead: Codable {
    let index: Int
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

struct SentenceFill: Codable {
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

