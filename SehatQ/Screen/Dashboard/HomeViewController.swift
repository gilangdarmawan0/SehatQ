//
//  HomeViewController.swift
//  SehatQ
//
//  Created by Gilang Darmawan on 02/07/20.
//  Copyright © 2020 SehatQ. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController{
    
    @IBOutlet weak var favouriteCheck: UICheckmark!    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var homeMenuButton: UIButton!
    @IBOutlet weak var feedMenuButton: UIButton!
    @IBOutlet weak var chartMenuButton: UIButton!
    @IBOutlet weak var profileMenuButton: UIButton!
    
    private let viewModel = HomeViewModel()
    private var dashboard : DashboardModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        setUpObserver()
        fetchAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

// MARK: Prepare UI
extension HomeViewController {
    private func prepareUI() {
        prepareCheckBoc()
        prepareLabel()
        prepareButton()
    }
    
    private func prepareCheckBoc(){
        self.favouriteCheck.setCheckBoxType(type: .favourite)
    }
    
    private func prepareLabel(){
        
    }
    
    private func prepareButton(){
        homeMenuButton.setTitle("Home", for: .normal)
        homeMenuButton?.style(style: ViewStyle.Button.mainToolbar)
        feedMenuButton.setTitle("Feed", for: .normal)
        feedMenuButton?.style(style: ViewStyle.Button.mainToolbar)
        chartMenuButton.setTitle("Chart", for: .normal)
        chartMenuButton?.style(style: ViewStyle.Button.mainToolbar)
        profileMenuButton.setTitle("Profile", for: .normal)
        profileMenuButton?.style(style: ViewStyle.Button.mainToolbar)
    }
    
    private func prepareCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self;
        let nib = UINib(nibName: "ProductItemHorizontalCell",bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "productItemHorizontalCell")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/4, height: 130)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        self.collectionView.collectionViewLayout = flowLayout
    }

    private func prepareTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ProductItemDashboardCell",bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "productItemDashboardCell")
    }
}

// MARK: Actions
extension HomeViewController {
    @IBAction func searchClicked(_ sender: Any) {
        let productSearchViewController : ProductSeachViewController = Navigator.initViewController(Navigator.Screen.productSearch) as! ProductSeachViewController
        productSearchViewController.productList = self.dashboard!.productPromo
        Navigator.push(viewController: self, targetViewController: productSearchViewController, animated: false)
    }
    
    @IBAction func homeClicked(_ sender: Any) {
        fetchAPI()
    }
    
    @IBAction func feedClicked(_ sender: Any) {
        
    }
    
    @IBAction func chartClicked(_ sender: Any) {
        
    }
    
    @IBAction func profileClicked(_ sender: Any) {
        let productHistoryViewController : UIViewController = Navigator.initViewController(Navigator.Screen.productHistory)
        Navigator.push(viewController: self, targetViewController: productHistoryViewController, animated: true)
    }
    
    @IBAction func favouriteClicked(_ sender: Any) {
        self.favouriteCheck.change()
    }
}

// MARK: Methods
extension HomeViewController{
    private func setUpObserver() {
        viewModel.dataDidChanges = { (finished, error) in
            self.removeSpinner()
            if !error {
                if (self.viewModel.response != nil){
                    let response = self.viewModel.response as? [ResponseModel]
                    self.dashboard = response![0].data
                    self.prepareCollectionView()
                    self.prepareTableView()
                    self.collectionView.reloadData()
                    self.tableView.reloadData()
                }else{
                    let errorMessage = "Please Check ypur internet connection then refresh the page"//self.viewModel.failedResponse!
                    let alert = UIAlertController(title: "Connection loss", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Refresh", style: UIAlertAction.Style.default, handler: { (action) in
                            self.fetchAPI()
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func setProductName(view:ProductItemDashboardViewControllerl, text:String){
         view.productName.style(style: TextStyle.titleSBBrownishGreyTwo14)
         view.productName.text = text
     }
    
    private func setProductImage(view:ProductItemDashboardViewControllerl, image:String){
        view.productImage?.sd_setImage(with:URL(string: image))
    }

    private func setProductFavourite(view:ProductItemDashboardViewControllerl, status:Bool){
        if (status){
            view.favouriteCheck.check()
        }else{
            view.favouriteCheck.uncheck()
        }
    }
    
    private func setCategoryName(view:ProductItemHorizontalViewController, text:String){
         view.productCategory.style(style: TextStyle.titleSBBrownishGreyTwo14)
         view.productCategory.text = text
     }
    
    private func setCategoryImage(view:ProductItemHorizontalViewController, image:String){
        view.productCategoryImage?.sd_setImage(with:URL(string: image))
    }
    
    private func prepareContainerView(view : ProductItemDashboardViewControllerl) {
         view.containerView.style(style: ViewStyle.View.floatingLow)
     }

    private func prepareCollectionContainerView(view : ProductItemHorizontalViewController) {
         view.containerView.style(style: ViewStyle.View.floatingLow)
     }

    private func fetchAPI(){
        self.showSpinner(onView: self.view)
        viewModel.fetchApiList()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension HomeViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dashboard!.productPromo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productItemDashboardCell", for: indexPath as IndexPath) as! ProductItemDashboardViewControllerl
        cell.selectionStyle = .none
        prepareContainerView(view:cell)
        setProductName(view: cell, text: self.dashboard!.productPromo[indexPath.row].title!)
        setProductImage(view: cell, image: self.dashboard!.productPromo[indexPath.row].imageUrl!)
        if (self.dashboard!.productPromo[indexPath.row].loved == 0){
            setProductFavourite(view: cell, status: false)
        }else{
            setProductFavourite(view: cell, status: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailViewController : ProductDetailViewController = Navigator.initViewController(Navigator.Screen.productDetail) as! ProductDetailViewController
        productDetailViewController.product = self.dashboard?.productPromo[indexPath.row]
        Navigator.push(viewController: self, targetViewController: productDetailViewController, animated: true)
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dashboard!.category.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productItemHorizontalCell", for: indexPath as IndexPath) as! ProductItemHorizontalViewController
        prepareCollectionContainerView(view:cell)
        setCategoryName(view: cell, text: self.dashboard!.category[indexPath.row].name!)
        setCategoryImage(view: cell, image: self.dashboard!.category[indexPath.row].imageUrl!)

        return cell
    }
}
