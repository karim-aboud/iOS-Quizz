//
//  Categorie.swift
//  Projet
//
//  Created by aboudk on 01/06/2022.
//

import UIKit

struct Categorie{
    let titre: String
    let image: UIImage
}

let categories:[Categorie] = [

    Categorie(titre: "Sport", image: UIImage(named: "sports")!),
    Categorie(titre: "Animal", image: UIImage(named: "animals")!),
    Categorie(titre: "Geography", image: UIImage(named: "geography")!),
    Categorie(titre: "History", image: UIImage(named: "history")!)


]
