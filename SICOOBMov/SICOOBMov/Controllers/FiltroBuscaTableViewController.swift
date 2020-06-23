//
//  FiltroBuscaTableViewController.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//

import UIKit

class FiltroBuscaTableViewController: UITableViewController {

    var titulo : String = ""
    var resultado : Array<String> = []
    var resultadoGenero : [Generos] = []
    var lastSelection : IndexPath!
    
    var filtroDelegate:filtroDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titulo
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if titulo == "Data" {
            return resultado.count
        }else{
            return resultadoGenero.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if titulo == "Data" {
            cell.textLabel?.text = resultado[indexPath.row]

        }else{
            cell.textLabel?.text = resultadoGenero[indexPath.row].title
        }
        
        cell.textLabel?.textColor = UIColor.Branco()
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.lastSelection != nil {
            self.tableView.cellForRow(at: self.lastSelection as IndexPath)?.accessoryView = .none
        }

        var imageView : UIImageView
        imageView  = UIImageView(frame:CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = UIImage(named:"check")

        self.tableView.cellForRow(at: indexPath)?.accessoryView = imageView
        self.lastSelection = indexPath
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        
        if titulo == "Data" {
            filtroDelegate?.anoRecebido(ano: resultado[self.lastSelection.row])
        }else{
            filtroDelegate?.generoRecebido(genero: resultadoGenero[indexPath.row])
        }
        
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if self.lastSelection != nil {
            //print(resultado[self.lastSelection.row])
        }
        
    }

}
