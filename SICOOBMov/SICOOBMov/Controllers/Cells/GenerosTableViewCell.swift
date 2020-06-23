//
//  GenerosTableViewCell.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//

import UIKit
import TagListView

class GenerosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var generos: TagListView!
    var aryTeglist = [String]()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
