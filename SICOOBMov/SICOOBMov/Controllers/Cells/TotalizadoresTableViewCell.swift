//
//  TotalizadoresTableViewCell.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//

import UIKit

class TotalizadoresTableViewCell: UITableViewCell {

    @IBOutlet weak var viewPopularidade: UIView!
    @IBOutlet weak var viewTotal: UIView!
    @IBOutlet weak var viewMedia: UIView!
    @IBOutlet weak var lblValorVotos: UILabel!
    @IBOutlet weak var lblValorMedia: UILabel!
    @IBOutlet weak var lblValorPopularidade: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
