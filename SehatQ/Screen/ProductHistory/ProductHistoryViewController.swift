//
//  ProductHistoryViewController.swift
//  SehatQ
//
//  Created by Gilang Darmawan on 02/07/20.
//  Copyright © 2020 SehatQ. All rights reserved.
//

import UIKit

class ProductHistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ProductHistoryViewModel()
    private var productList : [ProductPromoModel] = [ProductPromoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        setUpObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
        navigationController?.setNavigationBarHidden(false, animated: animated)
        UIBackHeader().set(viewController: self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

// MARK: Prepare UI
extension ProductHistoryViewController {
    private func prepareUI() {
        prepareView()
        prepareLabel()
        prepareButton()
        prepareTableView()
    }
    
    private func prepareView(){
        
    }
    
    private func prepareLabel(){
        
    }
    
    private func prepareButton(){
        
    }
    
    private func prepareTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ProductItemCell",bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "productItemCell")
    }
}

// MARK: Actions
extension ProductHistoryViewController {

}

// MARK: Methods
extension ProductHistoryViewController{
    private func setUpObserver() {
        
    }
    
    private func setupData(){
        self.productList = HistoryStorage.instance.getHistoryListProduct()!
        self.tableView.reloadData()
    }

    private func setProductPrice(view:ProductItemViewController, text:String){
         view.productPrice.style(style: TextStyle.textMedium14)
         view.productPrice.text = text
     }

    private func setProductImage(view:ProductItemViewController, image:String){
        view.productImage?.sd_setImage(with:URL(string: image))
    }
}

// MARK: UIBackHeaderDelegate
extension ProductHistoryViewController:UIBackHeaderDelegate{
    func onBackNavigation(_ sender: UIBarButtonItem!) {
        Navigator.pop(viewController: self, animated: true)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ProductHistoryViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productItemCell", for: indexPath as IndexPath) as! ProductItemViewController
        cell.selectionStyle = .none
        cell.productName.text = productList[indexPath.row].title
        cell.productImage?.sd_setImage(with: URL(string: productList[indexPath.row].imageUrl!))
        cell.productPrice.text = productList[indexPath.row].price
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailViewController : ProductDetailViewController = Navigator.initViewController(Navigator.Screen.productDetail) as! ProductDetailViewController
        productDetailViewController.product = self.productList[indexPath.row]
        Navigator.push(viewController: self, targetViewController: productDetailViewController, animated: true)
    }
}
