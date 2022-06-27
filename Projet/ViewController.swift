//
//  ViewController.swift
//  Projet
//
//  Created by aboudk on 30/03/2022.
//
 
import UIKit
import GameKit
import AudioToolbox
 
class ViewController: UIViewController {
    
    var questions = [Question]()
    let score = Score()
    var questionsDejaPosees : [Int] = []
    var questionCourante: Question? = nil
    
    var selectedCategory: Categorie?
    
 
    @IBOutlet weak var questionTexte: UILabel!
    @IBOutlet weak var correcteIncorrecteLbl: UILabel!
    
    @IBOutlet weak var premierBtn: UIButton!
    @IBOutlet weak var deuxiemeBtn: UIButton!
    @IBOutlet weak var troisiemeBtn: UIButton!
    @IBOutlet weak var quatriemeBtn: UIButton!
    @IBOutlet weak var questionSuivanteBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        correcteIncorrecteLbl.isHidden = true
        
        premierBtn.layer.cornerRadius = 15
        premierBtn.layer.masksToBounds = true
        
        deuxiemeBtn.layer.cornerRadius = 15
        deuxiemeBtn.layer.masksToBounds = true
        
        troisiemeBtn.layer.cornerRadius = 15
        troisiemeBtn.layer.masksToBounds = true
        
        quatriemeBtn.layer.cornerRadius = 15
        quatriemeBtn.layer.masksToBounds = true
        
        questionSuivanteBtn.layer.cornerRadius = 15
        questionSuivanteBtn.layer.masksToBounds = true
        
        
        initData()
        jouerSon(nomFichier: "dingding.wav")
    }

    func jouerSon(nomFichier:String){
            
        var sonDebutJeu: SystemSoundID = 0
        
        let bundleURL = Bundle.main.bundleURL
        let url = bundleURL.appendingPathComponent(nomFichier)

        let urlRef = url as CFURL

        let err = AudioServicesCreateSystemSoundID(urlRef, &sonDebutJeu)
        if err == kAudioServicesNoError{
            AudioServicesPlaySystemSoundWithCompletion(sonDebutJeu, {
                AudioServicesDisposeSystemSoundID(sonDebutJeu)
            })
        }
    }
    
    
    func lireQuestion(text:String){
        let verbatim = AVSpeechUtterance(string: text)
        verbatim.voice = AVSpeechSynthesisVoice(language: "fr-FR")
        verbatim.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(verbatim)
    }
    
 
    private func getData(from url :String, completionBlock: @escaping (Quizz) -> Void){
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response,error in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            
            // obtention des données
            var result: Quizz?
            do {
                result = try JSONDecoder().decode(Quizz.self, from: data)
            } catch {
                print("Erreur pendant la conversion: \(error.localizedDescription)")
            }
            
            guard let json = result else {
                
                return
            }
 
            completionBlock(json)
        })
        
        task.resume()
       
        
    }
    
 
    func initData(){
        // get questions and answers from API
        let category = selectedCategory?.titre
        
        print(category!)
        
       let url = "https://quizzios.pythonanywhere.com/quizz/\(category!)"
        
        print(url)  
       
        // get return value and replace attribute questions
        getData(from: url) { quizz in
            self.questions = quizz.questions
            self.score.setNbQuestionsParTour(nbQuestionsParTour: Double(quizz.questions.count))
            print("getData() quizz.questions.count = ", quizz.questions.count)
            
            DispatchQueue.main.async {
                self.afficherQuestion()
            }
        }
    }
 
    func getQuestionAleat() -> Question{
        if(questionsDejaPosees.count == Int(self.score.getNbQuestionsParTour())){
            questionsDejaPosees = []
        }
        var rand = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
        while(questionsDejaPosees.contains(rand)){
             rand = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
        }
        print("getQuestionAleat()  rand = " , rand)
        print(" getQuestionAleat() questions.count = ", questions.count)
        
        questionsDejaPosees.append(rand)
        return questions[rand]
 
    }
 
    func estTermine() -> Bool {
        return score.nbQuestionsPosees() >= score.getNbQuestionsParTour()
    }
    
    func afficherScore(){
        questionTexte.text = score.getScore()
        score.reset()
        questionSuivanteBtn.setTitle("Recommencer", for: .normal)
        correcteIncorrecteLbl.isHidden = true
        premierBtn.isHidden = false
        deuxiemeBtn.isHidden = false
        troisiemeBtn.isHidden = false
        quatriemeBtn.isHidden = false
    }
    
    @IBAction func verifReponse(_ sender: UIButton ){
        if let q = questionCourante, let rep = sender.titleLabel?.text {
            
            print("\n\nList Reponses = \(q.getReponses())")
            
            if(q.validerReponse(reponseFourni:rep)){
                score.incrReponsesCorrectes()
                correcteIncorrecteLbl.text = "Bonne réponse!"
                correcteIncorrecteLbl.textColor = UIColor(red:1, green: 1, blue: 0, alpha: 1.0)
                // SON BONNE REPONSE
            } else{
                score.incrReponsesInCorrectes()
                correcteIncorrecteLbl.text = "Mauvaise réponse!"
                
                sender.backgroundColor = 
                
                correcteIncorrecteLbl.textColor = UIColor(red:0.85, green: 0.30, blue: 0.31 , alpha: 1.0)
                // SON MAUVAISE REPONSE
            }
            premierBtn.isEnabled = false
            deuxiemeBtn.isEnabled = false
            troisiemeBtn.isEnabled = false
            quatriemeBtn.isEnabled = false
            correcteIncorrecteLbl.isHidden = false
            questionSuivanteBtn.isEnabled = true
        }
    }
    
    @IBAction func questionSuivanteBtnClick(){
        correcteIncorrecteLbl.isHidden = true
        if(estTermine()){
            afficherScore()
        } else{
            afficherQuestion()
        }
    }
    
    func afficherQuestion(){
        
        questionCourante = getQuestionAleat()
        questionSuivanteBtn.isEnabled = false
        
        premierBtn.isEnabled = true
        deuxiemeBtn.isEnabled = true
        troisiemeBtn.isEnabled = true
        quatriemeBtn.isEnabled = true
        
        if let q = questionCourante {
            let choix = q.getChoix()
            questionTexte.text = q.getQuestion()
            
            lireQuestion(text: q.getQuestion())
            
            premierBtn.setTitle(choix[0], for: .normal)
            deuxiemeBtn.setTitle(choix[1], for: .normal)
            troisiemeBtn.setTitle(choix[2], for: .normal)
            quatriemeBtn.setTitle(choix[3], for: .normal)
            
            
            if(score.nbQuestionsPosees() == score.getNbQuestionsParTour() - 1){
                questionSuivanteBtn.setTitle("Fin Quizz", for: .normal)
            } else{
                questionSuivanteBtn.setTitle("Question Suivante", for: .normal)
            }
            
            
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
 

