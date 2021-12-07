//
//  SearchViewController.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 06/21/21.
//

import UIKit
import ObjectMapper

class SearchViewController: UIViewController, NavigationControllerCustomDelegate {
    
    
    @IBOutlet weak var col_history: UICollectionView!
    @IBOutlet weak var col_myPost: UICollectionView!
    
    @IBOutlet weak var tf_search: UITextField!
    
    @IBOutlet weak var heightCollectionViewHistory: NSLayoutConstraint!
    
    var listNewfeed = [NewFeed]()
    var listKey = [KeySearch]()
    var page = 1
    var limit = 100
    var typeCar = POST_TYPE.CAR.rawValue
    var _idUser = ManageCacheObject.getCurrentAccount()._id
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tf_search.becomeFirstResponder()
        
        col_myPost.register(UINib(nibName: "NewFeedItemTableViewCell", bundle: nil), forCellWithReuseIdentifier: "NewFeedItemCollectionViewCell")
        
        
        tf_search.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                                  for: .editingChanged)
        
        self.col_myPost.isHidden = true
        setDoneOnKeyboard()
        getHistorySearch()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: true, searchButton: true, title: "Tìm kiếm bài viết")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.backgroundAppColor()
        navigationController?.navigationBar.backgroundColor = ColorUtils.backgroundAppColor()
        
    }

    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
//        let trimmedString = tf_search.text!.trimmingCharacters(in: .whitespaces)
//
//        if tf_search.text!.count >= 2 {
//            getNewfeed(text:trimmedString)
//        }
    }
    
    
    @IBAction func btn_search(_ sender: Any) {
        
//    let trimmedString = tf_search.text!.trimmingCharacters(in: .whitespaces)
//        let formattedString = tf_search.text!.replacingOccurrences(of: " ", with: "-")
//        getNewfeed(text:formattedString)
        createHistorySearch(text:tf_search.text!)
        
       
        
        let text = tf_search.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        getNewfeed(text:text!)
        
        
        switch tf_search.text!{
        case "xe hoi", "xe hơi","Xe hơi","Xe hoi","ô tô","Ô tô","KIA","morning":
            ManageCacheObject.setTypeSearch(POST_TYPE.CAR.rawValue)
        case "xe may","Xe may","xe máy","Xe máy","Honda","honda","Yamaha","yamaha":
            ManageCacheObject.setTypeSearch(POST_TYPE.MOTOCYCLE.rawValue)
        case "laptop", "máy tính", "may tinh","Máy tính","macbook","Macbook","May tinh":
            ManageCacheObject.setTypeSearch(POST_TYPE.LAPTOP.rawValue)
        case "điện thoại", "Điện thoại", "dien thoai","iphone","iPhone":
            ManageCacheObject.setTypeSearch(POST_TYPE.PHONE.rawValue)
        default:
           break
        }
        
        print("Dungtype")
        print("\(ManageCacheObject.getPrioritizeType())")
        
       
    }
    
    
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
    
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        let button = UIBarButtonItem(title: "Xong", style: .done, target: self, action: #selector(dismissKeyboard))
       
       
        keyboardToolbar.items = [flexBarButton, /*doneBarButton,*/ button]
        
        self.tf_search.inputAccessoryView = keyboardToolbar
       
    }
    
//    @objc func pressButton(_ sender: UIButton){
//        getNewfeed(text:tf_search.text!)
//    }
    
    func createHistorySearch(text:String){
        
        ResAPI.sharedInstance.postKeySearch(key:text, { (data, Message) -> Void in
                if(data != nil) {
                    let response:ResResponse = data as! ResResponse
                    if response.code == 200 {
                        
                       
                    } else {
                        let alert = UIAlertController(title:LOAD_FAIL , message: response.message, preferredStyle:.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    JHProgressHUD.sharedHUD.hide()
                }
                else {
                    Toast.show(message: "Thử lại", controller: self)
                    
                }
    
            })
        }
    
    func getNewfeed(text:String){
        
        ResAPI.sharedInstance.getNewFeedSearch(key:text, { (data, Message) -> Void in
                if(data != nil) {
                    let response:ResResponse = data as! ResResponse
                    if response.code == 200 {
                        if let DataResponse  = Mapper<NewFeedResponse>().map(JSONObject: response.data) {
                            self.col_history.isHidden = true
                            self.col_myPost.isHidden = false
                            self.heightCollectionViewHistory.constant = 0
                            
                            self.listNewfeed = DataResponse.list
                            self.col_myPost.reloadData()
                        }
                       
                    } else {
                        let alert = UIAlertController(title:LOAD_FAIL , message: response.message, preferredStyle:.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    JHProgressHUD.sharedHUD.hide()
                }
                else {
                    Toast.show(message: "Thử lại", controller: self)
                    
                }
    
            })
        }
    
    func getHistorySearch(){
        
        ResAPI.sharedInstance.getSearchHistory({(data, Message) -> Void in
                if(data != nil) {
                    let response:ResResponse = data as! ResResponse
                    if response.code == 200 {
                        if let DataResponse  = Mapper<KeySearch>().mapArray(JSONObject: response.data) {
                            self.listKey = DataResponse
                            self.col_history.reloadData()
                        }
                       
                    } else {
                        let alert = UIAlertController(title:LOAD_FAIL , message: response.message, preferredStyle:.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    JHProgressHUD.sharedHUD.hide()
                }
                else {
                    Toast.show(message: "Thử lại", controller: self)
                    
                }
    
            })
        }


    @IBAction func btn_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SearchViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == col_myPost {
            return listNewfeed.count
        }else{
            return listKey.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == col_myPost {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewFeedItemCollectionViewCell", for: indexPath) as!
                NewFeedItemCollectionViewCell
            
            let item = listNewfeed[indexPath.row]
            
            cell.delegate = self
            cell.pos = indexPath.row
            
            if item.images.count > 0 {
                if item.images[0].count == 0 {
                    cell.img_product.image = UIImage(named: "")
                }else{
    //                cell.img_product.loadImage(urlString: item.images[0])
                    cell.img_product.kf.setImage(with: URL(string: item.images[0]))
                }
            }
            
            cell.lbl_title.text = item.title
            
            cell.lbl_price.text = Utils.stringVietnameseMoneyFormatWithNumberInt(amount: item.price)
            cell.lbl_address.text = item.address
            cell.lbl_time.text = item.dateUpload
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistorySearchCollectionViewCell", for: indexPath) as!
                HistorySearchCollectionViewCell
            cell.lblTextHistory.text = listKey[indexPath.row].key
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == col_myPost{
           
        }else {
            self.getNewfeed(text: listKey[indexPath.row].key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if collectionView == col_myPost{
            return CGSize(width: col_myPost.bounds.width, height: 400)
        }else {
            return CGSize(width: col_myPost.bounds.width/2 - 10, height: 30)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == col_myPost {
            return 12
        }else{
            return 12
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == col_myPost {
            return 0
        }else{
            return 8
        }
    }
    
}

extension SearchViewController : DetailNewfeedDelegate {
    func showDetailPost(pos: Int) {
        let vc : DetailTransportViewController?
        vc = UIStoryboard.detailTransportViewController()
        vc!.newfeed = self.listNewfeed[pos]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func showListCar() {
        
    }
    
    func showListTech() {
        
    }
    
}

class HistorySearchCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var lblTextHistory: UILabel!
    @IBOutlet weak var viewParent: UIView!
}



