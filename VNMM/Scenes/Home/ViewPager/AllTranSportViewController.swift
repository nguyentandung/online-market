//
//  AllTranSportViewController.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 05/04/21.
//

import UIKit
import BmoViewPager

class AllTranSportViewController: UIViewController, NavigationControllerCustomDelegate {
    
    @IBOutlet weak var bmo_view_pager: BmoViewPager!
    @IBOutlet weak var segmented: SegmentedView!
    @IBOutlet weak var bmo_view_pager_navigation: BmoViewPagerNavigationBar!
    
    var reviewId = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.bmo_view_pager_navigation.viewPager = bmo_view_pager
        self.bmo_view_pager_navigation.layer.masksToBounds = true
        self.bmo_view_pager_navigation.layer.cornerRadius =  self.segmented.layer.cornerRadius
        self.bmo_view_pager.presentedPageIndex = 0
        self.bmo_view_pager.infinitScroll = false
        self.bmo_view_pager.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: false, filter: true, title: "")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.main_color()
        self.navigationItem.hidesBackButton = true
    }
    
    func backTap() {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension AllTranSportViewController : BmoViewPagerDataSource, BmoViewPagerDelegate
{
    func bmoViewPagerDataSourceNumberOfPage(in viewPager: BmoViewPager) -> Int {
        return 3
    }
    
    func bmoViewPagerDataSource(_ viewPager: BmoViewPager, viewControllerForPageAt page: Int) -> UIViewController {
        switch page {
        case 0:
            let vc: ListCarViewController =
                UIStoryboard.listCarViewController()!
            return vc
        case 1:
            let vc: ListMotoCycleViewController =
                UIStoryboard.ListMotoCycleViewController()!
            return vc
        case 2:
            return UIViewController()
        default:
            return UIViewController()
        }
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemNormalAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
        return [
            NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 15.0)!,
            NSAttributedString.Key.foregroundColor : UIColor.darkGray
        ]
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
        return [
            NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 15.0)!,
            NSAttributedString.Key.foregroundColor : ColorUtils.main_color()
        ]
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemTitle(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> String? {
        switch page {
        case 0:
            return "Xe lớn"
        case 1:
            return "Xe máy"
        case 2:
            return "Xe đạp"
        default:
            return String()
        }
    }

    func bmoViewPagerDataSourceNaviagtionBarItemSize(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> CGSize {
        return CGSize(width: navigationBar.bounds.width / 3, height: navigationBar.bounds.height)
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedBackgroundView(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> UIView? {
        let view = UIView()
        view.addBottomBorder()
        return view
    }
}

