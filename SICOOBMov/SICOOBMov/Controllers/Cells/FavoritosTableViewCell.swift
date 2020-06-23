//
//  FavoritosTableViewCell.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//

import UIKit

class FavoritosTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtAno: UILabel!
    @IBOutlet weak var txtDescricao: UILabel!
    @IBOutlet weak var imagem: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
