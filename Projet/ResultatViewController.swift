//
//  ResultatViewController.swift
//  Projet
//
//  Created by aboudk on 29/06/2022.
//

import UIKit

class ResultatViewController: UIViewController {
    
    
    @IBOutlet weak var resultatLabel: UILabel!
    var resultat = ""
    var score:Double = 0
    var nbTotalQuestions:Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultatLabel.text = resultat
        
        let ratio:Double = score/nbTotalQuestions
        
        if ratio == 1 {
           
            playSound(son: "ctsur.mp3")
            
        } else if(ratio >= 0.65 && ratio <= 1){
           
            // SON 75 %
            
        } else if (ratio >= 0.45 && ratio <= 0.65){
            // SON 65 %
            
            
        } else if(ratio >= 0.20 && ratio <= 0.45){
            playSound(son: "impossible")
            
        } else{
            // SON < 20 %
            playSound(son: "nul.mp3")
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    func playSound(son : String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "viewController") as! ViewController
        VC.jouerSon(nomFichier: son)
    }
    
    
    
    @IBAction func goToMain(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}

