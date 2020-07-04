//
//  ProductSeachViewController.swift
//  SehatQ
//
//  Created by Gilang Darmawan on 03/07/20.
//  Copyright © 2020 SehatQ. All rights reserved.
//

import Foundation
import UIKit

class ProductSeachViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backButton: UIButton!
    
    private let viewModel = ProductHistoryViewModel()
    public var productList : [ProductPromoModel] = [ProductPromoModel]()
    private var filteredData : [ProductPromoModel] = [ProductPromoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        setUpObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

// MARK: Prepare UI
extension ProductSeachViewController {
    private func prepareUI() {
        prepareButton()
        prepareSearchBar()
        prepareTableView()
    }
            
    private func prepareButton(){
        backButton.setImage(ImageAsset.ic_back, for: .normal)
    }
    
    private func prepareSearchBar(){
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
    private func prepareTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ProductItemCell",bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "productItemCell")
    }
}

// MARK: Actions
extension ProductSeachViewController {
    @IBAction func backNavigation(_ sender: Any) {
        Navigator.pop(viewController: self, animated: false)
    }
}

// MARK: Methods
extension ProductSeachViewController {
    private func setUpObserver() {
        
    }
    
    private func setProductName(view:ProductItemViewController, text:String){
         view.productName.style(style: TextStyle.titleSBBrownishGreyTwo14)
         view.productName.text = text
     }

    private func setProductPrice(view:ProductItemViewController, text:String){
         view.productPrice.style(style: TextStyle.textMedium14)
         view.productPrice.text = text
     }

    private func setProductImage(view:ProductItemViewController, image:String){
        view.productImage?.sd_setImage(with:URL(string: image))
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ProductSeachViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productItemCell", for: indexPath as IndexPath) as! ProductItemViewController
        cell.selectionStyle = .none
        setProductName(view: cell, text: filteredData[indexPath.row].title!)
        setProductPrice(view: cell, text: filteredData[indexPath.row].price!)
        setProductImage(view: cell, image: filteredData[indexPath.row].imageUrl!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailViewController : ProductDetailViewController = Navigator.initViewController(Navigator.Screen.productDetail) as! ProductDetailViewController
        productDetailViewController.product = self.filteredData[indexPath.row]
        Navigator.push(viewController: self, targetViewController: productDetailViewController, animated: true)
    }
}

// MARK: UISearchBarDelegate
extension ProductSeachViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData = searchText.isEmpty ? productList : productList.filter{ $0.title!.range(of: searchText, options: .caseInsensitive) != nil }
        tableView.reloadData()
    }
}
