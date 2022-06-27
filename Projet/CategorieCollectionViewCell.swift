//
//  CategorieCollectionViewCell.swift
//  Projet
//
//  Created by aboudk on 01/06/2022.
//

import UIKit

class CategorieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categorieImageView: UIImageView!
    
    @IBOutlet weak var titreLbl: UILabel!
    
    func setup(with categorie: Categorie){
        categorieImageView.image = categorie.image
        titreLbl.text = categorie.titre
    }
    
}
