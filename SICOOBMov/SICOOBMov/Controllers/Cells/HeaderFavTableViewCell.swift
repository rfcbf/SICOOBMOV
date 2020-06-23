//
//  HeaderFavTableViewCell.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//

import UIKit

class HeaderFavTableViewCell: UITableViewCell {
    
    var delegate: pesquisaDelegate? = nil

    @IBOutlet weak var btnRemoverFiltro: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnRemoverFiltro(_ sender: Any) {
        delegate?.removerFiltro()
    }
}
