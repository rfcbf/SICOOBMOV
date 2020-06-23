//
//  SemConexao.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//

import UIKit

class SemConexao: UIView {

    class func instanceFromNib() -> SemConexao {
        return UINib(nibName: "SemConexao", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SemConexao
    }
}
