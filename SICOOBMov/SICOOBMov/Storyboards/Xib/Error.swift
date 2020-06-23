//
//  error.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//

import UIKit

class Error: UIView {
    
    class func instanceFromNib() -> Error {
        return UINib(nibName: "Error", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Error
    }
}
