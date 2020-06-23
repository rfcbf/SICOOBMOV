//
//  FirstViewController.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//

import UIKit
import SDWebImage


class FilmesViewController: UIViewController {
    
    
    var pag = 1
    var carregando = false
    
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    var result : Array<Filmes> = []
    var filtro: Array<Filmes> = []
    
    @IBOutlet weak var collection: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)

    var filtrandoDados : Bool = false
            
    override func viewDidLoad() {
        
        
        collection.dataSource = self
        collection.delegate = self
        
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setLeftBarButton(barButton, animated: true)
        activityIndicator.color = UIColor.FonteSecundaria()
        activityIndicator.hidesWhenStopped = true
        
        super.viewDidLoad()
        
        self.collection.collectionViewLayout = self.collectionViewFlowLayout
        
        self.result = []
        self.filtro = []
        
        carregandoDados(pag: self.pag)

        self.navigationController?.setStatusBar(backgroundColor: UIColor.Principal())
        self.navigationController?.navigationBar.backgroundColor = UIColor.Principal()
        self.navigationController?.navigationBar.tintColor = UIColor.Branco()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear

        //pesquisa
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = ""
        searchController.searchBar.backgroundColor = UIColor.Principal()
        searchController.searchBar.tintColor = UIColor.FontePrimaria()
        searchController.searchBar.searchTextField.backgroundColor = UIColor.Branco()
        navigationItem.searchController = searchController
        
        
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        searchController.isActive = false
        collection.backgroundView = UIView.init()
        restorarDados()
    }
    
    

    
    func carregandoDados(pag: Int){
        if !filtrandoDados {
            do{
                self.result.append(contentsOf: try FilmeServices.getFilmes(pag: pag))
                filtro = result
            }catch{
                print("erro")
            }
        }
    }
    
    lazy var collectionViewFlowLayout : CustomCollectionViewFlowLayout = {
        let layout = CustomCollectionViewFlowLayout(display: .grid(columns: 2), containerWidth: self.view.bounds.width)
        return layout
    }()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.reloadCollectionViewLayout(self.view.bounds.size.width)
    }
    
    private func reloadCollectionViewLayout(_ width: CGFloat) {
        
        self.collectionViewFlowLayout.containerWidth = width
        self.collectionViewFlowLayout.display = CollectionDisplay.grid(columns: 2)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if contentHeight > 0 {
            if offsetY > contentHeight - scrollView.frame.height {
                if !carregando {
                    beginBatchFetch()
                }
                
            }
        }
    }
    
    func beginBatchFetch() {
        self.pag += 1
        self.carregando = true
        activityIndicator.startAnimating()
        
        Utils().delayWithSeconds(1) {
            self.carregandoDados(pag: self.pag)
            
            self.collection.reloadData()
            self.carregando = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    func filtrando(termo: String){
        
        if termo.count > 0 {
            filtro = []
            filtrandoDados = true
            for item in self.result {
                if (item.title.lowercased().contains(searchController.searchBar.text!.lowercased())) {
                    self.filtro.append(item)
                }
            }
            collection.reloadData()
        }else{
            filtro = result
            collection.reloadData()

        }
    }
    
    func restorarDados(){
        filtrandoDados = false
        filtro = result
        collection.reloadData()
    }
    
    
    
}


extension FilmesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: Collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtro.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionView.backgroundView  = UIView.init()
        
        if filtro.count == 0 {
            if filtrandoDados {
                
                let vcSemRegistro = SemRegistro.instanceFromNib()
                vcSemRegistro.texto.sizeToFit()
                vcSemRegistro.texto.text = "Sua busca por '\(String(describing: searchController.searchBar.text!))' não resultou em nunhum resultado."
                collectionView.backgroundView = vcSemRegistro
                return 0
                
            }else{
                let vcError = Error.instanceFromNib()
                collectionView.backgroundView = vcError
                return 0
            }
        }
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellFilmes", for: indexPath) as! FilmesCollectionViewCell
        
        let resultado: Filmes
        resultado = filtro[indexPath.row]
        
        let urlImagem = URL(string: "\(Constantes.URL_IMAGEM)\(resultado.poster)")
        
        //borda na celula
        cell.contentView.layer.borderColor = UIColor.FonteSecundaria().cgColor
        cell.contentView.layer.borderWidth = 0.25
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.masksToBounds = true
        
        //sombra na celular
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        //arrendondando canto esquerdo inferior
        //layerMaxXMaxYCorner – lower right corner
        //layerMaxXMinYCorner – top right corner
        //layerMinXMaxYCorner – lower left corner
        //layerMinXMinYCorner – top left corner
        cell.viewFavorito.layer.cornerRadius = 10
        cell.viewFavorito.layer.maskedCorners = [.layerMinXMaxYCorner]
        cell.viewFavorito.layer.masksToBounds = true
        
        let favoritado = Favoritos.verificaSeFilmeFavoritado(id: String(resultado.id))
        
        favoritado == true ? cell.btnFavorito.setImage(UIImage(named: "favorite_full"), for: .normal) : cell.btnFavorito.setImage(UIImage(named: "favorite_gray"), for: .normal)
        
        result[indexPath.row].favorito = favoritado
        resultado.favorito = favoritado
        
        cell.filme = resultado
        
        cell.lblNome.text = resultado.title
        cell.imagem.sd_setImage(with: urlImagem, placeholderImage: UIImage(named: "placeholder.png"), options: [.refreshCached, .progressiveLoad])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        self.navigationController?.removeStatusBar()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor.FonteSecundaria()
        
        let filmeSelecionado: Filmes
        filmeSelecionado = filtro[indexPath.row]
                
        let vc = UIStoryboard.init(name: "Detail", bundle: Bundle.main).instantiateViewController(withIdentifier: "detalhes") as? DetailViewController
        vc?.filmes = filmeSelecionado
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension FilmesViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filtrando(termo: searchText)
        }
    }
        
}

extension FilmesViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchController.isActive = false
        if let searchText = searchBar.text {
            filtrando(termo: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        collection.backgroundView = UIView.init()
        restorarDados()
    }
    
}
