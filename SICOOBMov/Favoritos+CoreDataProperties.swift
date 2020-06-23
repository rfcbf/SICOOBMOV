//
//  Favoritos+CoreDataProperties.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//
//

import Foundation
import CoreData


extension Favoritos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favoritos> {
        return NSFetchRequest<Favoritos>(entityName: "Favoritos")
    }

    @NSManaged public var adulto: Bool
    @NSManaged public var ano: String?
    @NSManaged public var descricao: String?
    @NSManaged public var id: String?
    @NSManaged public var imagemFundo: String?
    @NSManaged public var linguagemOriginal: String?
    @NSManaged public var mediaVoto: Double
    @NSManaged public var popularidade: Double
    @NSManaged public var poster: String?
    @NSManaged public var title: String?
    @NSManaged public var totalVotos: Double

}
