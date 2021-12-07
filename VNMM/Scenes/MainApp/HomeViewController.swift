//
//  HomeViewController.swift
//  TechresSupplier
//
//  Created by Nguyen Tan Dung on 04/21/21.
//

import UIKit
import ImageSlideshow
import ObjectMapper
import Foundation


class HomeViewController: UIViewController, NavigationControllerCustomDelegate {
    
    @IBOutlet weak var tbl_home: UITableView!
    var token = ""
    var listImageUrl = ["https://images.pexels.com/photos/249538/pexels-photo-249538.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260","https://images.pexels.com/photos/1974596/pexels-photo-1974596.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                        "https://images.pexels.com/photos/244206/pexels-photo-244206.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260","https://images.pexels.com/photos/4071887/pexels-photo-4071887.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"]
    
    var listNewfeed = [NewFeed]()
    var limit = 100
    var page = 1
    var total_record = 0
    var typeAll = -1
    
    var prioritize_type = ManageCacheObject.getPrioritizeType()

    override func viewDidLoad() {
        super.viewDidLoad()
//        checkLogin()
        tbl_home.separatorStyle = .none
        
        tbl_home.register(UINib(nibName: "SlideImage", bundle: nil), forCellReuseIdentifier: "SlideImageTableViewCell")
        tbl_home.register(UINib(nibName: "ProductCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductCategoryTableViewCell")
        tbl_home.register(UINib(nibName: "ViewSpaceTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewSpaceTableViewCell")
        tbl_home.register(UINib(nibName: "NewFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "NewFeedTableViewCell")
        
        getNewfeed()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.getNewfeed()
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton:true, addButton:true, title:"")
        navigationItem.hidesBackButton = true

        navigationControllerCustom.navigationBar.barTintColor = UIColor.clear

    }
    
    
    
    @IBAction func btn_search(_ sender: Any) {
        
        let vc : SearchViewController?
        vc = UIStoryboard.searchViewController()
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func getNewfeed(){
        
        ResAPI.sharedInstance.getNewFeed(page: self.page, limit: self.limit,type:typeAll,prioritize_type:self.prioritize_type,{ (data, Message) -> Void in
                if(data != nil) {
                    let response:ResResponse = data as! ResResponse
                    if response.code == 200 {
                        if let DataResponse  = Mapper<NewFeedResponse>().map(JSONObject: response.data) {
                            
                            self.listNewfeed = DataResponse.list
                            self.tbl_home.reloadData()
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
        

    
}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SlideImageTableViewCell", for: indexPath) as! SlideImageTableViewCell
            
            cell.image_slideShow.slideshowInterval = 3.5
            cell.image_slideShow.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
            cell.image_slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
            
            let pageControl = UIPageControl()
            pageControl.currentPageIndicatorTintColor = UIColor.lightGray
            pageControl.pageIndicatorTintColor = UIColor.black
            cell.image_slideShow.pageIndicator = pageControl

            cell.image_slideShow.activityIndicator = DefaultActivityIndicator()
    
            
            var alamofireSource = [AlamofireSource]()
            
            for item in 0..<self.listImageUrl.count {
                let source = AlamofireSource(url: URL(string: self.listImageUrl[item])!)
                alamofireSource.append(source)
            }
            cell.image_slideShow.setImageInputs(alamofireSource)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCategoryTableViewCell", for: indexPath) as! ProductCategoryTableViewCell
            cell.delegate = self
            return cell
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ViewSpaceTableViewCell", for: indexPath) as! ViewSpaceTableViewCell
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewFeedTableViewCell", for: indexPath) as! NewFeedTableViewCell
            
            cell.delegate = self
            
            cell.listNewfeed = self.listNewfeed
            
            cell.col_newFeed.reloadData()
            return cell
        }
       
    }
    
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 215
        case 1:
            return 300
        case 2:
            return 8
        default:
            return CGFloat((self.listNewfeed.count * 300 )/2 + 250)
        }
    }
    
    
}

extension HomeViewController : DetailNewfeedDelegate {
    func showListCar() {
        let vc : AllTranSportViewController?
        vc = UIStoryboard.allTranSportViewController()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func showListTech() {
        
    }
    
    func showDetailPost(pos: Int) {
        let vc : DetailTransportViewController?
        vc = UIStoryboard.detailTransportViewController()
        vc!.newfeed = self.listNewfeed[pos]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
