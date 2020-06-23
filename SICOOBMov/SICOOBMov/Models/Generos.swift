//
//  Generos.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//
import UIKit
import CoreData

class Generos {
    
    var id: Int
    var idFilme : String!
    var title: String
    
    init(){
        self.id = 0
        self.idFilme = ""
        self.title = ""
    }
    
    init(id: Int,
         idFilme : String,
         title: String){
        
        self.id = id
        self.title = title
        self.idFilme = idFilme
    }
}


extension Genero{
    
    //funcao para retornar o context principal
    static func context() -> NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    static func salvar(){
        
        if context().hasChanges {
            do {
                try Genero.context().save()
            } catch {
                print("Falha ao salvar: \(error)")
            }
        }
    }
    
    static func inserirGenero(generos: Generos){
        let managedObj = Genero(context: context())
        
        managedObj.idGenero = String(generos.id)
        managedObj.idFilme = generos.idFilme
        
        salvar()
    }
    
    static func apagarGeneros(filmeID : String){
        
        let predicate = NSPredicate(format: "idFilme == %@", filmeID)
        
        let fetchRequest: NSFetchRequest<Genero> = Genero.fetchRequest()
        fetchRequest.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try self.context().execute(deleteRequest)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    static func getTodosGenerosFavoritados() -> [Generos] {
        var array = [Generos]()
        
        let fetchRequest: NSFetchRequest<Genero> = Genero.fetchRequest()
        
        do {
            let fetchResult = try context().fetch(fetchRequest)
            
            for item in fetchResult{
                
                let result = Generos(id: Int((item.idGenero! as NSString).intValue),
                                     idFilme: item.idFilme!,
                                     title: "")
                                
                array.append(result)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        return array
    }
    
    static func getGenerosFiltro(idGeneros: String ) -> Array<String> {
        var array = Array<String>()
        
        let predicate = NSPredicate(format: "idGenero == %@", idGeneros)
        
        let fetchRequest: NSFetchRequest<Genero> = Genero.fetchRequest()
        fetchRequest.predicate = predicate
        
        do {
            let fetchResult = try context().fetch(fetchRequest)

            for item in fetchResult{
                array.append(item.idFilme!)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        return array
    }
    
}
