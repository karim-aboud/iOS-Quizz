//
//  Question.swift
//  Projet
//
//  Created by aboudk on 31/03/2022.
//

import Foundation

class Question : Codable{
    let question: String
    let reponses: [String]
    let indexReponseCorrecte: Int
    
    init(question: String, reponses: [String], indexReponseCorrecte: Int){
        self.question = question
        self.reponses = reponses
        self.indexReponseCorrecte = indexReponseCorrecte
    }
    
    func validerReponse(reponseFourni: String) -> Bool {
        print("Nb Reponses = \(reponses.count)")
        print("reponse foruni: \(reponseFourni)")
        print("index reponse correcte: \(indexReponseCorrecte)" )
        return (reponseFourni == reponses[indexReponseCorrecte])
    }
    
    func getQuestion() -> String {
        return question
    }
    
    func getReponses() -> [String] {
        return self.reponses
    }
    
    
    func getReponse() -> String {
        return reponses[indexReponseCorrecte]
    }
    
    func getChoix() -> [String] {
        return reponses
    }
    
    func getReponseIndex(index:Int) -> String {
        return reponses[index]
    }
    
    
}
