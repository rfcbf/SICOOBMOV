//
//  FilmeServices.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//

import UIKit
import SwiftyJSON

class FilmeServices: NSObject {
    
    static func getFilmes(pag : Int) throws -> [Filmes] {
        var filmes = [Filmes]()
        let semaphone = DispatchSemaphore(value: 0)
        let url = URL(string:"https://api.themoviedb.org/3/movie/popular?api_key=\(Constantes.API_KEY)&language=pt-BR&page=\(String(pag))")
        var request = URLRequest(url: url!)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }else{
                do {
                    let json = try JSON(data: data!)
                                        
                    for (_,subJson):(String, JSON) in json["results"] {
                        
                        let ano : String = String(String(subJson["release_date"].stringValue).prefix(4))
                        
                        var generosFilme = [Int]()
                        let generosNomes = [String]()
                        let generosProducao = [String]()
                        
                        for (_,genero):(String, JSON) in subJson["genre_ids"] {
                            generosFilme.append(genero.intValue)
                        }
                        
//                        let favoritado = Favoritos.verificaSeFilmeFavoritado(id: subJson["id"].stringValue)
                        let favoritado = false
                        
                        let filme = Filmes(id: subJson["id"].intValue,
                                           title: subJson["title"].stringValue,
                                           descricao: subJson["overview"].stringValue,
                                           ano: ano,
                                           adulto: subJson["adult"].boolValue,
                                           imagemFundo: subJson["backdrop_path"].stringValue,
                                           generosID: generosFilme,
                                           generosNomes: generosNomes,
                                           producao: generosProducao,
                                           linguagemOriginal: subJson["original_language"].stringValue,
                                           popularidade: subJson["popularity"].doubleValue,
                                           poster: subJson["poster_path"].stringValue,
                                           mediaVoto: subJson["vote_average"].doubleValue,
                                           totalVotos: subJson["vote_count"].doubleValue,
                                           favorito: favoritado)
                        
                        
                        
                        filmes.append(filme)
                        
                    }
                    
                }catch{
                    print("erro json")
                    return
                }
                
                semaphone.signal()
            }
            
        }.resume()
        
        _ = semaphone.wait(timeout: .distantFuture)
        
        return filmes
    }
    
    
    static func getDetalhesFilme(filme : Filmes ) throws -> Filmes {
        
        let semaphone = DispatchSemaphore(value: 0)
        
        let url = URL(string:"https://api.themoviedb.org/3/movie/\(String(filme.id))?api_key=\(Constantes.API_KEY)&language=pt-BR")
        var request = URLRequest(url: url!)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }else{
                do {
                    let json = try JSON(data: data!)
                                        
                    var generosFilme = [String]()
                    var producoes = [String]()

                    for (_,subJson):(String, JSON) in json["genres"] {
                        generosFilme.append(subJson["name"].string!)
                    }
                    
                    for (_,subJson):(String, JSON) in json["production_companies"] {
                        producoes.append(subJson["name"].string!)
                    }


                    filme.generosNomes = generosFilme
                    filme.producao = producoes

                }catch{
                    print("erro json")
                    return
                }
                
                semaphone.signal()
            }
            
        }.resume()
        
        _ = semaphone.wait(timeout: .distantFuture)
        
        return filme
    }
    
    
    static func getGeneros() throws -> [Generos] {
        var generos = [Generos]()
        let semaphone = DispatchSemaphore(value: 0)
        
        let url = URL(string:"https://api.themoviedb.org/3/genre/movie/list?api_key=\(Constantes.API_KEY)&language=pt-BR")
        var request = URLRequest(url: url!)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }else{
                do {
                    let json = try JSON(data: data!)
                                        
                    for (_,subJson):(String, JSON) in json["genres"] {
                        let genero = Generos.init(id: subJson["id"].intValue, idFilme: "", title:subJson["name"].stringValue)
                        generos.append(genero)
                    }
                }catch{
                    print("erro json")
                    return
                }
                
                semaphone.signal()
            }
            
        }.resume()
        
        _ = semaphone.wait(timeout: .distantFuture)
        
        return generos
    }
    
}
