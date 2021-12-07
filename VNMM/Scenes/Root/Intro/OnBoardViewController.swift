//
//  OnBoardViewController.swift
//  Techres-Supplier
//
//  Created by kelvin on 11/04/2021.
//  Copyright © 2021 aloapp. All rights reserved.
//

import UIKit
import paper_onboarding
import ObjectMapper


class OnBoardViewController: UIViewController, NavigationControllerCustomDelegate {
    @IBOutlet var skipButton: UIButton!
    
    var baseNavigationController: NavigationControllerCustom!
    
    fileprivate let items = [
        OnboardingItemInfo(informationImage: Asset.giftbox.image,
                           title: "Bất động sản",
                           description: "Bao gồm nhà cửa, đất đai,phòng trọ, căn hộ mini",
                           pageIcon: Asset.icon_page_giftbox.image,
                           color: ColorUtils.backgroundAppColor(),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.fooddelivery.image,
                           title: "Xe cộ",
                           description: "Các phương tiện di chuyển như xe hơi, xe máy, xe đạp",
                           pageIcon: Asset.icon_page_fooddelivery.image,
                           color: ColorUtils.lowOrangeColor(),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.discount.image,
                           title: "Đồ gia dụng",
                           description: "Các đồ dùng như tủ lạnh, máy giặt, dành cho sinh hoạt",
                           pageIcon: Asset.icon_page_discount.image,
                           color: ColorUtils.backgroundAppColor(),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.piggybank.image,
                           title: "Trái cây,đồ ăn uống",
                           description: "Trái cây,đồ ăn,các món được ưa chuộng",
                           pageIcon: Asset.icon_page_piggybank.image,
                           color: ColorUtils.lowOrangeColor(),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.review.image,
                           title: "Đánh giá",
                           description: "Đánh giá, review nhà hàng bàn vừa trải nghiệm",
                           pageIcon: Asset.icon_page_review.image,
                           color:ColorUtils.backgroundAppColor(),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.takeaway.image,
                           title: "Đồ công nghệ",
                           description: "Các sản phẩm công nghệ như máy tính, điện thoại, máy tính bảng...",
                           pageIcon: Asset.icon_page_takeaway.image,
                           color: ColorUtils.lowOrangeColor(),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        OnboardingItemInfo(informationImage: Asset.giftbox.image,
                           title: "Việc làm",
                           description: "Các công việc cần tuyển dụng",
                           pageIcon: Asset.icon_page_giftbox.image,
                           color: ColorUtils.backgroundAppColor(),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
      
        
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        skipButton.isHidden = false

        setupPaperOnboardingView()

        view.bringSubviewToFront(skipButton)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    
    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)

        // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    
    
}
extension OnBoardViewController {

    @IBAction func skipButtonTapped(_: UIButton) {

       
        if(!ManageCacheObject.isLogin()){
            var mainViewController: MainViewController?
            mainViewController = UIStoryboard.mainViewController()
            self.navigationController!.pushViewController(mainViewController!, animated: false)
        }else{
            let loginViewController: LoginViewController?
            loginViewController = UIStoryboard.loginViewController()
            self.navigationController!.pushViewController(loginViewController!, animated: false)
        }

        /*
        let mainViewController: ViewController?
        mainViewController = UIStoryboard.viewController()
        baseNavigationController = NavigationControllerCustom(rootViewController: mainViewController!)
        
        view.addSubview(baseNavigationController.view)
        
        baseNavigationController.didMove(toParent: self)

        baseNavigationController.touchTarget = self
        

        
        NotificationCenter.default.addObserver(self, selector: #selector(OnBoardViewController.rotation), name: NSNotification.Name(rawValue: "AddNotificationRotation"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(OnBoardViewController.removeRotation), name: NSNotification.Name(rawValue: "RemoveNotificationRotation"), object: nil)
        */
        if(ManageCacheObject.isLogin()){
            var mainViewController: MainViewController?
            mainViewController = UIStoryboard.mainViewController()
            self.navigationController!.pushViewController(mainViewController!, animated: false)
        }else{
            let loginViewController: LoginViewController?
            loginViewController = UIStoryboard.loginViewController()
            self.navigationController!.pushViewController(loginViewController!, animated: false)
        }
//
//
//        var mainViewController: MainViewController?
//        mainViewController = UIStoryboard.mainViewController()
//        self.navigationController!.pushViewController(mainViewController!, animated: false)
        
//        let loginViewController: LoginViewController?
//        loginViewController = UIStoryboard.loginViewController()
//        self.navigationController!.pushViewController(loginViewController!, animated: false)
        
//        
//        if(ManageCacheObject.isLogin()){
//            var mainViewController: MainViewController?
//            mainViewController = UIStoryboard.mainViewController()
//            self.navigationController!.pushViewController(mainViewController!, animated: false)
//        }else{
//            let loginViewController: LoginViewController?
//            loginViewController = UIStoryboard.loginViewController()
//            self.navigationController!.pushViewController(loginViewController!, animated: false)
//        }

        ManageCacheObject.setFistRun(false)
       
        
    }

}

// MARK: PaperOnboardingDelegate

extension OnBoardViewController: PaperOnboardingDelegate {

    func onboardingWillTransitonToIndex(_ index: Int) {
//        skipButton.isHidden = index == 5 ? false : true
    }

    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
        //item.titleCenterConstraint?.constant = 100
        //item.descriptionCenterConstraint?.constant = 100
        
        // configure item
        
        //item.titleLabel?.backgroundColor = .redColor()
        //item.descriptionLabel?.backgroundColor = .redColor()
        //item.imageView = ...
    }
}

// MARK: PaperOnboardingDataSource

extension OnBoardViewController: PaperOnboardingDataSource {

    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }

    func onboardingItemsCount() -> Int {
        return 7
    }
    
    //    func onboardinPageItemRadius() -> CGFloat {
    //        return 2
    //    }
    //
    //    func onboardingPageItemSelectedRadius() -> CGFloat {
    //        return 10
    //    }
    //    func onboardingPageItemColor(at index: Int) -> UIColor {
    //        return [UIColor.white, UIColor.red, UIColor.green][index]
    //    }
}


//MARK: Constants
private extension OnBoardViewController {
    
    static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
}
