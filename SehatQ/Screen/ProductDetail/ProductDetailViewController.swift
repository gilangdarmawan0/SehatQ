//
//  ProductDetailViewController.swift
//  SehatQ
//
//  Created by Gilang Darmawan on 02/07/20.
//  Copyright © 2020 SehatQ. All rights reserved.
//

import UIKit
import SDWebImage

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescLabel: UILabel!
    @IBOutlet weak var favouriteCheck: UICheckmark!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    private let viewModel = ProductDetailViewModel()
    public var product : ProductPromoModel? = nil
    private var timerPopup : Timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        setUpObserver()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

// MARK: Prepare UI
extension ProductDetailViewController {
    private func prepareUI() {
        prepareLabel()
        prepareButton()
    }
    
    private func prepareLabel(){
        productNameLabel.style(style: TextStyle.titleSBBrownishGreyTwo14)
        productDescLabel.style(style: TextStyle.textRegular12)
        priceLabel.style(style: TextStyle.textMedium14)
    }
    
    private func prepareButton(){
        buyButton.setTitle("Buy", for: .normal)
        buyButton?.style(style: ViewStyle.Button.main)
        backButton.setImage(ImageAsset.ic_back, for: .normal)
        shareButton.setImage(ImageAsset.ic_share, for: .normal)
    }
}

// MARK: Actions
extension ProductDetailViewController {
    @IBAction func buyClicked(_ sender: Any) {
        storeLocalStorage()
        self.showPopupSuccess("Product purchased, Thank you")
    }
    
    @IBAction func favouriteClicked(_ sender: Any) {
        self.favouriteCheck.change()
    }
    
    @IBAction func backClicked(_ sender: Any) {
        Navigator.pop(viewController: self, animated: true)
    }
    
    @IBAction func shareClicked(_ sender: Any) {
        let message = "Come visit here."
        //Set the link to share.
        if let link = NSURL(string: "http://www.sehatq.com")
        {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
        }
    }
}

// MARK: Methods
extension ProductDetailViewController {
    private func setUpObserver() {

    }
    
    private func setupData(){
        self.productImage?.sd_setImage(with: URL(string: (self.product?.imageUrl!)!))
        self.priceLabel.text = self.product?.price
        self.productNameLabel.text = self.product?.title
        self.productDescLabel.text = self.product?.description
        if (self.product?.loved == 0){
            self.favouriteCheck.uncheck()
        }else{
            self.favouriteCheck.check()
        }
    }
    
    private func showPopupSuccess(_ text: String) {
        let popup : UIPopup1ViewController = Popup.initViewController(Popup.Context.popup1) as! UIPopup1ViewController
        popup.imageMain = ImageAsset.ic_success!
        popup.labelMain = text
        Popup.show(viewController: self, targetViewController: popup)
        
        timerPopup = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(hidePopupSuccess), userInfo: nil, repeats: true)
    }
    
    @objc private func hidePopupSuccess() {
        timerPopup.invalidate()
        timerPopup = Timer()
        Popup.dismiss(viewController: self)
    }
    
    private func storeLocalStorage(){
        HistoryStorage.instance.storeHistoryProduct(self.product!)
    }
}
