//
//  FiltroPrincipalViewController.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//

import UIKit


protocol filtroDelegate
{
    func anoRecebido(ano: String)
    func generoRecebido(genero: Generos)
}

class FiltroPrincipalViewController: UIViewController, filtroDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAplicar: UIButton!
    var linhaSelecionada : Int = 0
    var favoritos : Array<Filmes> = []
    var generos : Array<Generos> = []
    
    var listaAnos : Array<String> = []
    var listaGeneros : Array<String> = []
        
    var ano: String = "";
    var genero = Generos()
    
    var delegate: pesquisaDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listaAnos = []
        listaGeneros = []
        favoritos = []
        generos = []
        
        recuperarDados()
        
        self.navigationController?.setStatusBar(backgroundColor: UIColor.Principal())
        self.navigationController?.navigationBar.backgroundColor = UIColor.Principal()
        self.navigationController?.navigationBar.tintColor = UIColor.FonteSecundaria()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        btnAplicar.layer.cornerRadius = 12
        btnAplicar.clipsToBounds = true
    }
    
    func recuperarDados(){
        preencheListaAnos()
        preencheGeneros()
    }
    
    func preencheListaAnos(){
        favoritos = Favoritos.getTodosFavoritos()
        
        for itemFavoritos in favoritos {
            if listaAnos.isEmpty {
                listaAnos.append(itemFavoritos.ano)
            }else{
                if !listaAnos.contains(itemFavoritos.ano) {
                    listaAnos.append(itemFavoritos.ano)
                }
            }
        }
        
        listaAnos.sort {$0 < $1}
    }
    
    func preencheGeneros(){
        do {
            generos = try FilmeServices.getGeneros()
        }catch{
            print("erro ao carregar generos")
        }
                
        generos.sort {$0.title < $1.title}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.title = "Filtro"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: Protocol
    func anoRecebido(ano: String) {
        self.ano = ano
        tableView.reloadData()
    }

    func generoRecebido(genero: Generos) {
        self.genero = genero
        tableView.reloadData()
    }
    
    @IBAction func btnAplicar(_ sender: Any) {
        
        if ano == "" , genero.title == "" {
            let alerta = UIAlertController(title: "Movs", message: "Favor selecionar um ano ou um gênero", preferredStyle: .alert)
            let botaoAlerta = UIAlertAction(title: "OK", style: .default, handler: nil)
            alerta.addAction(botaoAlerta)
            present(alerta, animated: true, completion: nil)
        }else if ano != "" , genero.title == ""{
            delegate?.dadosRecebidoFiltro(ano: ano, genero: "")
            _ = navigationController?.popViewController(animated: true)
        }else if ano == "" , genero.title != ""{
            delegate?.dadosRecebidoFiltro(ano: "", genero: String(genero.id))
            _ = navigationController?.popViewController(animated: true)
        }else{
            delegate?.dadosRecebidoFiltro(ano: ano, genero: String(genero.id))
            _ = navigationController?.popViewController(animated: true)
        }
        

    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedIndex = tableView.indexPath(for: sender as! UITableViewCell)
        let vc: FiltroBuscaTableViewController = segue.destination as! FiltroBuscaTableViewController

        if selectedIndex?.row == 0 {
            vc.titulo = "Data"
            vc.resultado = listaAnos
        }else{
            vc.titulo = "Gênero"
            vc.resultadoGenero = generos

        }
        vc.filtroDelegate = self
    }

}

extension FiltroPrincipalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FiltroTableViewCell

        if indexPath.row == 0 {
            cell.lblFiltro.text = "Data"
            cell.lblResultadoFiltro.text = ""
            if !ano.isEmpty{
                cell.lblResultadoFiltro.text = ano
            }else{
                cell.lblResultadoFiltro.text = ""
            }
        }else if indexPath.row == 1 {
            cell.lblFiltro.text = "Gênero"
            cell.lblResultadoFiltro.text = ""

            if genero.title != "" {
                cell.lblResultadoFiltro.text = genero.title
            }else{
                cell.lblResultadoFiltro.text = ""
            }
            
        }
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.linhaSelecionada = indexPath.row
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
}
