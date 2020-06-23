//
//  Filmes.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//

import UIKit
import CoreData

class Filmes {
    
    var id: Int
    var title: String
    var descricao: String
    var ano: String
    var adulto : Bool
    var imagemFundo : String
    var generosID : Array<Int>
    var generosNomes : Array<String>
    var producao : Array<String>
    var linguagemOriginal : String
    var popularidade : Double
    var poster : String
    var mediaVoto : Double
    var totalVotos : Double
    var favorito : Bool
    
    
    init(){
        self.id = 0
        self.title = ""
        self.descricao = ""
        self.adulto = false
        self.imagemFundo = ""
        self.generosID = []
        self.generosNomes = []
        self.producao = []
        self.linguagemOriginal = ""
        self.popularidade = 0
        self.poster = ""
        self.mediaVoto = 0
        self.totalVotos = 0
        self.ano = ""
        self.favorito = false
    }
    
    init(id: Int,
         title: String,
         descricao: String ,
         ano: String,
         adulto : Bool,
         imagemFundo : String,
         generosID : Array<Int>,
         generosNomes : Array<String>,
         producao : Array<String>,
         linguagemOriginal : String,
         popularidade : Double,
         poster : String,
         mediaVoto : Double,
         totalVotos : Double,
         favorito : Bool){
        
        self.id = id
        self.title = title
        self.descricao = descricao
        self.adulto = adulto
        self.imagemFundo = imagemFundo
        self.generosID = generosID
        self.generosNomes = generosNomes
        self.producao = producao
        self.linguagemOriginal = linguagemOriginal
        self.popularidade = popularidade
        self.poster = poster
        self.mediaVoto = mediaVoto
        self.totalVotos = totalVotos
        self.ano = ano
        self.favorito = favorito
    }
}

extension Favoritos {
    
    //funcao para retornar o context principal
    static func context() -> NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    static func salvar(){
        
        if context().hasChanges {
            do {
                try Favoritos.context().save()
            } catch {
                print("Falha ao salvar: \(error)")
            }
        }
    }
    
    static func inserirFavoritos(filme: Filmes){
        let managedObj = Favoritos(context: context())
        
        managedObj.id = String(filme.id)
        managedObj.title = filme.title
        managedObj.descricao = filme.descricao
        managedObj.ano = filme.ano
        managedObj.adulto = filme.adulto
        managedObj.imagemFundo = filme.imagemFundo
        managedObj.linguagemOriginal = filme.linguagemOriginal
        managedObj.popularidade = filme.popularidade
        managedObj.totalVotos = filme.totalVotos
        managedObj.mediaVoto = filme.mediaVoto
        managedObj.poster = filme.poster
        
        salvar()
        
        for genero in filme.generosID{
            let gravarGenero = Generos.init(id: genero, idFilme: String(filme.id), title: "")
            Genero.inserirGenero(generos: gravarGenero)
        }
        
    }
    
    static func apagarFavoritos(filme: Filmes){
        
        let predicate = NSPredicate(format: "id == %@", String(filme.id))
        
        let fetchRequest: NSFetchRequest<Favoritos> = Favoritos.fetchRequest()
        fetchRequest.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            Genero.apagarGeneros(filmeID: String(filme.id))
            try self.context().execute(deleteRequest)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    static func verificaSeFilmeFavoritado(id: String) -> Bool{
        
        let predicate = NSPredicate(format: "id == %@", id)
        
        let fetchRequest: NSFetchRequest<Favoritos> = Favoritos.fetchRequest()
        fetchRequest.predicate = predicate
        
        do {
            let fetchResult = try self.context().fetch(fetchRequest)
            
            return fetchResult.count == 0 ? false : true
        } catch {
            print(error.localizedDescription)
        }
        
        return false
        
    }
    
    static func getTodosFavoritos() -> [Filmes] {
        var array = [Filmes]()
        
        let fetchRequest: NSFetchRequest<Favoritos> = Favoritos.fetchRequest()
        
        do {
            let fetchResult = try context().fetch(fetchRequest)
            
            for item in fetchResult{
                
                let result = Filmes(id: Int((item.id! as NSString).intValue) ,
                                    title: item.title!,
                                    descricao: item.descricao!,
                                    ano: item.ano!,
                                    adulto: item.adulto,
                                    imagemFundo: item.imagemFundo!,
                                    generosID: [],
                                    generosNomes: [],
                                    producao: [],
                                    linguagemOriginal: item.linguagemOriginal!,
                                    popularidade: item.popularidade,
                                    poster: item.poster!,
                                    mediaVoto: item.mediaVoto,
                                    totalVotos: item.totalVotos,
                                    favorito: true)
                
                array.append(result)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        return array
    }
    
    static func getFilmesFiltro(ano: String) -> [Filmes]{
        var array = [Filmes]()
        let predicate = NSPredicate(format: "ano == %@", ano)
        
        let fetchRequest: NSFetchRequest<Favoritos> = Favoritos.fetchRequest()
        fetchRequest.predicate = predicate
        
        do {
            let fetchResult = try context().fetch(fetchRequest)

            for item in fetchResult{
                           
               let result = Filmes(id: Int((item.id! as NSString).intValue) ,
                                   title: item.title!,
                                   descricao: item.descricao!,
                                   ano: item.ano!,
                                   adulto: item.adulto,
                                   imagemFundo: item.imagemFundo!,
                                   generosID: [],
                                   generosNomes: [],
                                   producao: [],
                                   linguagemOriginal: item.linguagemOriginal!,
                                   popularidade: item.popularidade,
                                   poster: item.poster!,
                                   mediaVoto: item.mediaVoto,
                                   totalVotos: item.totalVotos,
                                   favorito: true)
                           
                           array.append(result)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        return array
        
    }
    
    static func getFilmesFiltroPorGenero(idFilmes: Array<String>) -> [Filmes]{
        let filmes : [Filmes] = self.getTodosFavoritos()
        var array = [Filmes]()
        
        for id in idFilmes {
            
            let filme = filmes.filter({
                $0.id == Int(id)
            })
            
            array.append(contentsOf: filme)
            
        }
        
        return array
        
    }
    
}

extension Array where Element: Equatable {
    func contains(array: [Element]) -> Bool {
        for item in array {
            if !self.contains(item) { return false }
        }
        return true
    }
}
