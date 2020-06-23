//
//  FilmesCollectionViewCell.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//

import UIKit

class FilmesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblNome: UILabel!
    @IBOutlet weak var btnFavorito: UIButton!
    @IBOutlet weak var imagem: UIImageView!
    
    @IBOutlet weak var viewFavorito: UIView!
    
    var favorito : Bool = false
    var filme = Filmes()
        
    
    @IBAction func btnFavoritar(_ sender: Any) {
        if !filme.favorito {
            filme.favorito = true
            btnFavorito.setImage(UIImage(named: "favorite_full"), for: .normal)
            Favoritos.inserirFavoritos(filme: filme)
        } else {
            filme.favorito = false
            btnFavorito.setImage(UIImage(named: "favorite_gray"), for: .normal)
            Favoritos.apagarFavoritos(filme: filme)
        }
    }
    
    
}
