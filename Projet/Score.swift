//
//  Score.swift
//  Projet
//
//  Created by aboudk on 04/04/2022.
//

import Foundation
import UIKit


class Score {
    var reponsesCorrectes:Double = 0
    var reponsesIncorrectes:Double = 0
    var nbQuestionsParTour:Double = 0

    
    func setNbQuestionsParTour(nbQuestionsParTour: Double){
        self.nbQuestionsParTour = nbQuestionsParTour
    }

    func reset(){
        reponsesCorrectes = 0
        reponsesIncorrectes = 0
    }

    func incrReponsesCorrectes() {
        reponsesCorrectes+=1
    }

    func incrReponsesInCorrectes(){
        reponsesIncorrectes+=1
    }

    func nbQuestionsPosees() -> Double {
        return reponsesCorrectes + reponsesIncorrectes
    }
    
    func getNbQuestionsParTour() -> Double {
        return self.nbQuestionsParTour
    }
    

    func getScore() -> String {
        let ratio:Double =  reponsesCorrectes / nbQuestionsParTour
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "viewController") as! ViewController
        nextVC.getChoice()
        
        if( ratio == 1){
            return "Génie!\n\n Ton score: \(Int(reponsesCorrectes))/\(Int(nbQuestionsParTour))"
        } else if(ratio >= 0.75 && ratio <= 1){
            return "Excellent!\n\n Ton score \(Int(reponsesCorrectes))/\(Int(nbQuestionsParTour))"
        } else if (ratio >= 0.65 && ratio <= 0.75){
            return "Pas mal!\n\n Ton score \(Int(reponsesCorrectes))/\(Int(nbQuestionsParTour))"
        }else{
            return "Réesaye encore! \n\n Ton score \(Int(reponsesCorrectes))/\(Int(nbQuestionsParTour))"
        }
    }
}

