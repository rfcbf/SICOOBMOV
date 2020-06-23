//
//  semRegistro.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//

import UIKit

class SemRegistro: UIView {

    @IBOutlet weak var texto: UILabel!
    
    class func instanceFromNib() -> SemRegistro {
        return UINib(nibName: "SemRegistro", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SemRegistro
    }
    
}
