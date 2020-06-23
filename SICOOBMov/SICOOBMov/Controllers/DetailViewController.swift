//
//  DetailViewController.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//

import UIKit
import TagListView
import DeviceKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var imgFundo: UIImageView!
    @IBOutlet weak var viewFavorito: UIView!
    @IBOutlet weak var btnFavorito: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewImagem: UIView!
    
    var filmes = Filmes()
    var row : Int = 0

    override func viewDidLoad() {

        do{
            self.filmes = try FilmeServices.getDetalhesFilme(filme: filmes)
        }catch{
            print("erro ao carregar detalhes do filme")
        }

        configurandoFundo()
        configurandoPoster()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor.Branco()
        self.tabBarController?.tabBar.isHidden = true
        
        self.navigationController?.removeStatusBar()

        viewFavorito.layer.cornerRadius = 10
        viewFavorito.layer.maskedCorners = [.layerMaxXMinYCorner]
        viewFavorito.layer.masksToBounds = true
        
        filmes.favorito == true ? btnFavorito.setImage(UIImage(named: "favorite_full"), for: .normal) : btnFavorito.setImage(UIImage(named: "favorite_gray"), for: .normal)
        
        super.viewDidLoad()
        
    }
            
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.backgroundColor = UIColor.Principal()
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.tintColor = UIColor.FonteSecundaria()
        self.navigationController?.setStatusBar(backgroundColor: UIColor.Principal())

        tabBarController?.tabBar.isHidden = false
    }
    
    func configurandoPoster(){
        let urlImagemPoster = URL(string: "\(Constantes.URL_IMAGEM)\(filmes.poster)")
        self.imgPoster.sd_setImage(with: urlImagemPoster, placeholderImage: UIImage(named: "placeholder.png"), options: [.refreshCached, .progressiveLoad])
        self.imgPoster.layer.shadowColor = UIColor.black.cgColor
        self.imgPoster.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        self.imgPoster.layer.shadowRadius = 3.0
        self.imgPoster.layer.shadowOpacity = 0.5
        self.imgPoster.layer.masksToBounds = false
        self.imgPoster.layer.shadowPath = UIBezierPath(roundedRect: self.imgPoster.bounds, cornerRadius: self.imgPoster.layer.cornerRadius).cgPath
    }

    func configurandoFundo(){
        let urlImagemFundo = URL(string: "\(Constantes.URL_IMAGEM)\(filmes.imagemFundo)")
        self.imgFundo.sd_setImage(with: urlImagemFundo, placeholderImage: UIImage(named: "placeholder.png"), options: [.refreshCached, .progressiveLoad])
    }

    
    @IBAction func btnFavorito(_ sender: Any) {
        if !filmes.favorito {
            filmes.favorito = true
            btnFavorito.setImage(UIImage(named: "favorite_full"), for: .normal)
            Favoritos.inserirFavoritos(filme: filmes)
        } else {
            filmes.favorito = false
            btnFavorito.setImage(UIImage(named: "favorite_gray"), for: .normal)
            Favoritos.apagarFavoritos(filme: filmes)
        }

    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configurandoViews(view: UIView, corFundo: UIColor){
        view.backgroundColor = corFundo
        view.layer.borderColor = UIColor.FonteSecundaria().cgColor
        view.layer.borderWidth = 0.25
        view.layer.cornerRadius = 10.0

        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        view.layer.shadowRadius = 3.0
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            let device = Device.current
//            if device.isPhone {
//              // iPhone (real or simulator)
//                return 150.0
//            } else if device.isPad {
//              // iPad (real or simulator)
//                return 300.0
//            }
//        }
    
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TotalizadoresTableViewCell

            (cell as! TotalizadoresTableViewCell).lblValorPopularidade.text = Utils().convertNumberStringFormatado(valor: filmes.popularidade)
            (cell as! TotalizadoresTableViewCell).lblValorVotos.text = Utils().convertNumberStringFormatado(valor: filmes.totalVotos)
            (cell as! TotalizadoresTableViewCell).lblValorMedia.text = Utils().convertNumberStringFormatado(valor: filmes.mediaVoto)

            configurandoViews(view: (cell as! TotalizadoresTableViewCell).viewPopularidade, corFundo: UIColor.Principal())
            configurandoViews(view: (cell as! TotalizadoresTableViewCell).viewTotal, corFundo: UIColor.Principal())
            configurandoViews(view: (cell as! TotalizadoresTableViewCell).viewMedia, corFundo: UIColor.Principal())
            
        }  else if  indexPath.row == 3 {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! GenerosTableViewCell

            (cell as! GenerosTableViewCell).generos.textFont = UIFont.systemFont(ofSize: 16)
            (cell as! GenerosTableViewCell).generos.alignment = .left
                        
            (cell as! GenerosTableViewCell).generos.addTags(filmes.generosNomes)
        } else if  indexPath.row == 5 {
                cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! GenerosTableViewCell

                (cell as! GenerosTableViewCell).generos.textFont = UIFont.systemFont(ofSize: 16)
                (cell as! GenerosTableViewCell).generos.alignment = .left
                            
                (cell as! GenerosTableViewCell).generos.addTags(filmes.producao)
        }else{
            
            cell = tableView.dequeueReusableCell(withIdentifier: "cellOutros", for: indexPath) as! OutrosTableViewCell
            if  indexPath.row == 1 {
                (cell as! OutrosTableViewCell).lblTexto.text = filmes.title
            }else if indexPath.row == 2 {
                (cell as! OutrosTableViewCell).lblTexto.text = filmes.ano
            }else if indexPath.row == 4{
                (cell as! OutrosTableViewCell).lblTexto.text = filmes.descricao
            }

        }
        
        return cell
    }    
    
}

