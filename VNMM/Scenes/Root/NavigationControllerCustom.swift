//
//  NavigationControllerCustom.swift
//  kelvin
//
//  Created by kelvin on 11/3/18.
//  Copyright © 2018 vn.printstudio. All rights reserved.
//

import UIKit
import Foundation


@objc protocol NavigationControllerCustomDelegate {
    @objc optional func backTap()
    @objc optional func filterTap()
    @objc optional func searchTap()
    @objc optional func actionTap()
    @objc optional func voiceTap()
    @objc optional func addTap()
    @objc optional func contactTap()
    @objc optional func createGroupTap()
    @objc optional func menuTap()
    @objc optional func editTap()
}

class NavigationControllerCustom: UINavigationController {

    var backButton : UIButton!
    var voiceButton : UIButton!
    var filterButton : UIButton!
    var searchButton : UIButton!
    var addButton : UIButton!
    var contactButton : UIButton!
    var createGroupButton : UIButton!
    var menuButton : UIButton!
    var editButton : UIButton!
    var touchTarget : NavigationControllerCustomDelegate?
    var textTitle : UILabel!
    var backGroundView:UIView!
    var logo :UIImageView!
    var logoChat :UIImageView!
    var numberLabel : UILabel!
    var heightNavigationBar : CGFloat = 0
    var heightButton : CGFloat = 20
    var fontSizeButton : CGFloat = 25
    var widthButton : CGFloat = 30
    var setTopAction : Bool = false
    var labelNotification:UILabel!
    var isMenuHidden = true
    var search = UISearchBar()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    func setUpView() {
        
            let heightNavi = self.navigationBar.frame.size.height
            let widthNavi = self.navigationBar.frame.size.width
            let statusBarSize = UIApplication.shared.statusBarFrame.size
            heightNavigationBar = heightNavi + statusBarSize.height

            self.navigationItem.hidesBackButton = true
            self.navigationBar.barTintColor = ColorUtils.main_color()
            let viewBackground = UIView(frame: CGRect(x: 0, y: -45, width: widthNavi, height: heightNavi+45))
        viewBackground.backgroundColor = ColorUtils.main_color()
            self.navigationBar.addSubview(viewBackground)
            
            textTitle = UILabel(frame: CGRect(x: widthNavi/2 - (widthNavi - 80)/2, y: 0, width: widthNavi - 80, height: heightNavi))
            textTitle.backgroundColor = UIColor.clear
            textTitle.textColor = UIColor.white
            textTitle.textAlignment = NSTextAlignment.center
            textTitle.font = UIFont.fontDefaultSemiBoldSize(18.0)
            textTitle.isUserInteractionEnabled = true
            self.navigationBar.addSubview(textTitle)
            
            logo = UIImageView(frame: CGRect(x: widthNavi/2 - 50, y: 5, width: 150, height: 30))
            logo.backgroundColor = UIColor.clear
            let logo_image = UIImage(named: "header_logo.png")
            logo.image = logo_image
            self.navigationBar.addSubview(logo)
        
            logoChat = UIImageView(frame: CGRect(x: 50, y: 0, width: 40, height: 40))
            logoChat.backgroundColor = UIColor.clear
            logoChat.image = UIImage(named: "header_logo.png")
            logoChat.cornerRadius = 20
            logoChat.clipsToBounds = true
            logoChat.contentMode = .scaleAspectFill
            self.navigationBar.addSubview(logoChat)
         
            search = UISearchBar(frame: CGRect(x: 10, y: 5, width: widthNavi - 20, height: 30))
            search.placeholder = "Nhập để tìm kiếm..."
            search.tintColor = .white
            search.barTintColor = .white
            self.navigationBar.addSubview(search)
            
            backButton = UIButton(frame: CGRect(x: 0.0, y: 0, width: 40, height: 40))
            backButton?.showsTouchWhenHighlighted = true
            
            if let image = UIImage(named: "icon_back") {
                backButton.setImage(image, for: .normal)
                backButton.tintColor = ColorUtils.white()
            }
            backButton.setTitleColor(UIColor.white, for: UIControl.State())
            backButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            backButton.addTarget(self, action:#selector(NavigationControllerCustom.backTap), for: UIControl.Event.touchUpInside)
            backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(backButton)
        
            editButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            editButton?.showsTouchWhenHighlighted = true

            if let image = UIImage(named: "icon_edit") {
                editButton.setImage(image, for: .normal)
                editButton.tintColor = ColorUtils.white()
            }
            editButton.setTitleColor(UIColor.white, for: UIControl.State())
            editButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            editButton.addTarget(self, action:#selector(NavigationControllerCustom.editTap), for: UIControl.Event.touchUpInside)
            editButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(editButton)
            
            addButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            addButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "icon_add") {
                addButton.setImage(image, for: .normal)
                addButton.tintColor = ColorUtils.white()
            }
            
            addButton.setTitleColor(UIColor.white, for: UIControl.State())
            addButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            addButton.addTarget(self, action:#selector(NavigationControllerCustom.addTap), for: UIControl.Event.touchUpInside)
            addButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(addButton)
        
            contactButton = UIButton(frame: CGRect(x: widthNavi - 90, y: 5, width: 30, height: 30))
            contactButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "contact") {
                contactButton.setImage(image, for: .normal)
                contactButton.tintColor = ColorUtils.white()
            }
            contactButton.setTitleColor(UIColor.white, for: UIControl.State())
            contactButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            contactButton.addTarget(self, action:#selector(NavigationControllerCustom.contactTap), for: UIControl.Event.touchUpInside)
            contactButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(contactButton)
            
            createGroupButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            createGroupButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "add-group") {
                createGroupButton.setImage(image, for: .normal)
                createGroupButton.tintColor = ColorUtils.white()
            }
            createGroupButton.setTitleColor(UIColor.white, for: UIControl.State())
            createGroupButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            createGroupButton.addTarget(self, action:#selector(NavigationControllerCustom.createGroupTap), for: UIControl.Event.touchUpInside)
            createGroupButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(createGroupButton)
        
            menuButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            menuButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "menu_button_icon") {
                menuButton.setImage(image, for: .normal)
                menuButton.tintColor = ColorUtils.white()
            }
            
            menuButton.setTitleColor(UIColor.white, for: UIControl.State())
            menuButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            menuButton.addTarget(self, action:#selector(NavigationControllerCustom.menuTap), for: UIControl.Event.touchUpInside)
            menuButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(menuButton)
            
            
            voiceButton = UIButton(frame: CGRect(x: 10.0, y: 0, width: 30, height: 30))
            voiceButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "icon_voice") {
                voiceButton.setImage(image, for: .normal)
                voiceButton.tintColor = ColorUtils.white()
            }
            
            voiceButton.setTitleColor(UIColor.white, for: UIControl.State())
            voiceButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            voiceButton.addTarget(self, action:#selector(NavigationControllerCustom.voiceTap), for: UIControl.Event.touchUpInside)
            voiceButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(voiceButton)
            
            
            
            filterButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            filterButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "baseline_filter_list_black_48pt") {
                filterButton.setImage(image, for: .normal)
            }
            
            filterButton.setTitleColor(UIColor.white, for: UIControl.State())
            filterButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            filterButton.tintColor = ColorUtils.white()
            filterButton.addTarget(self, action:#selector(NavigationControllerCustom.filterTap), for: UIControl.Event.touchUpInside)
            filterButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(filterButton)
            
            
            searchButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 35, height: 35))
            searchButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "icon_search") {
                searchButton.setImage(image, for: .normal)
            }
            
            searchButton.setTitleColor(UIColor.white, for: UIControl.State())
            searchButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            searchButton.tintColor = ColorUtils.white()
            searchButton.addTarget(self, action:#selector(NavigationControllerCustom.searchTap), for: UIControl.Event.touchUpInside)
            searchButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(searchButton)
            
            
            numberLabel = UILabel(frame: CGRect(x: widthNavi - widthButton, y: 20, width: widthButton , height: heightButton))
            numberLabel.backgroundColor = UIColor.clear
            numberLabel.textAlignment = NSTextAlignment.center
            numberLabel.font = UIFont.fontDefaultRegularSize(11.0)
            numberLabel.text = "99+"
            numberLabel.isHidden = true
            numberLabel.textColor = UIColor.yellow
            numberLabel.isUserInteractionEnabled = false
            backButton.isHidden = true
            textTitle.isHidden = true
            filterButton.isHidden = true
            addButton.isHidden = true
            contactButton.isHidden = true
            createGroupButton.isHidden = true
            menuButton.isHidden = true
            logo.isHidden = true
            logoChat.isHidden = true
            voiceButton.isHidden = true
            searchButton.isHidden = true
            search.isHidden = true
            editButton.isHidden = true
    }
    
    func setUpViewGradient() {
        
            let heightNavi = self.navigationBar.frame.size.height
            let widthNavi = self.navigationBar.frame.size.width
            let statusBarSize = UIApplication.shared.statusBarFrame.size
            heightNavigationBar = heightNavi + statusBarSize.height

            self.navigationItem.hidesBackButton = true
            self.navigationBar.barTintColor = ColorUtils.main_color()
            let viewBackground = UIView(frame: CGRect(x: 0, y: -45, width: widthNavi, height: heightNavi+45))
        
        
            let colorTop =  UIColor(red: 255.0/255.0, green: 150.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor

            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.frame = viewBackground.bounds
                    
            viewBackground.layer.insertSublayer(gradientLayer, at:0)
        
            self.navigationBar.addSubview(viewBackground)
            
            textTitle = UILabel(frame: CGRect(x: widthNavi/2 - (widthNavi - 80)/2, y: 0, width: widthNavi - 80, height: heightNavi))
            textTitle.backgroundColor = UIColor.clear
            textTitle.textColor = UIColor.white
            textTitle.textAlignment = NSTextAlignment.center
            textTitle.font = UIFont.fontDefaultSemiBoldSize(18.0)
            textTitle.isUserInteractionEnabled = true
            self.navigationBar.addSubview(textTitle)
            
            logo = UIImageView(frame: CGRect(x: widthNavi/2 - 50, y: 5, width: 150, height: 30))
            logo.backgroundColor = UIColor.clear
            let logo_image = UIImage(named: "header_logo.png")
            logo.image = logo_image
            self.navigationBar.addSubview(logo)
        
            logoChat = UIImageView(frame: CGRect(x: 50, y: 0, width: 40, height: 40))
            logoChat.backgroundColor = UIColor.clear
            logoChat.image = UIImage(named: "header_logo.png")
            logoChat.cornerRadius = 20
            logoChat.clipsToBounds = true
            logoChat.contentMode = .scaleAspectFill
            self.navigationBar.addSubview(logoChat)
         
            search = UISearchBar(frame: CGRect(x: 10, y: 5, width: widthNavi - 20, height: 30))
            search.placeholder = "Nhập để tìm kiếm..."
            search.tintColor = .white
            search.barTintColor = .white
            self.navigationBar.addSubview(search)
            
            backButton = UIButton(frame: CGRect(x: 0.0, y: 0, width: 40, height: 40))
            backButton?.showsTouchWhenHighlighted = true
            
            if let image = UIImage(named: "icon_back") {
                backButton.setImage(image, for: .normal)
                backButton.tintColor = ColorUtils.white()
            }
            backButton.setTitleColor(UIColor.white, for: UIControl.State())
            backButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            backButton.addTarget(self, action:#selector(NavigationControllerCustom.backTap), for: UIControl.Event.touchUpInside)
            backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(backButton)
        
            editButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            editButton?.showsTouchWhenHighlighted = true
            
        if let image = UIImage(named: "icon_edit") {
            editButton.setImage(image, for: .normal)
            editButton.tintColor = ColorUtils.white()
        }
        editButton.setTitleColor(UIColor.white, for: UIControl.State())
        editButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
        editButton.addTarget(self, action:#selector(NavigationControllerCustom.editTap), for: UIControl.Event.touchUpInside)
        editButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        self.navigationBar.addSubview(editButton)
        
            addButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            addButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "icon_add") {
                addButton.setImage(image, for: .normal)
                addButton.tintColor = ColorUtils.white()
            }
            
            addButton.setTitleColor(UIColor.white, for: UIControl.State())
            addButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            addButton.addTarget(self, action:#selector(NavigationControllerCustom.addTap), for: UIControl.Event.touchUpInside)
            addButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(addButton)
        
            contactButton = UIButton(frame: CGRect(x: widthNavi - 90, y: 5, width: 30, height: 30))
            contactButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "contact") {
                contactButton.setImage(image, for: .normal)
                contactButton.tintColor = ColorUtils.white()
            }
            contactButton.setTitleColor(UIColor.white, for: UIControl.State())
            contactButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            contactButton.addTarget(self, action:#selector(NavigationControllerCustom.contactTap), for: UIControl.Event.touchUpInside)
            contactButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(contactButton)
            
            createGroupButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            createGroupButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "add-group") {
                createGroupButton.setImage(image, for: .normal)
                createGroupButton.tintColor = ColorUtils.white()
            }
            createGroupButton.setTitleColor(UIColor.white, for: UIControl.State())
            createGroupButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            createGroupButton.addTarget(self, action:#selector(NavigationControllerCustom.createGroupTap), for: UIControl.Event.touchUpInside)
            createGroupButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(createGroupButton)
        
            menuButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            menuButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "menu_button_icon") {
                menuButton.setImage(image, for: .normal)
                menuButton.tintColor = ColorUtils.white()
            }
            
            menuButton.setTitleColor(UIColor.white, for: UIControl.State())
            menuButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            menuButton.addTarget(self, action:#selector(NavigationControllerCustom.menuTap), for: UIControl.Event.touchUpInside)
            menuButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(menuButton)
            
            
            voiceButton = UIButton(frame: CGRect(x: 10.0, y: 0, width: 30, height: 30))
            voiceButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "icon_voice") {
                voiceButton.setImage(image, for: .normal)
                voiceButton.tintColor = ColorUtils.white()
            }
            
            voiceButton.setTitleColor(UIColor.white, for: UIControl.State())
            voiceButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            voiceButton.addTarget(self, action:#selector(NavigationControllerCustom.voiceTap), for: UIControl.Event.touchUpInside)
            voiceButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(voiceButton)
            
            
            
            filterButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            filterButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "baseline_filter_list_black_48pt") {
                filterButton.setImage(image, for: .normal)
            }
            
            filterButton.setTitleColor(UIColor.white, for: UIControl.State())
            filterButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            filterButton.tintColor = ColorUtils.white()
            filterButton.addTarget(self, action:#selector(NavigationControllerCustom.filterTap), for: UIControl.Event.touchUpInside)
            filterButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(filterButton)
            
            
            searchButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 35, height: 35))
            searchButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "icon_search") {
                searchButton.setImage(image, for: .normal)
            }
            
            searchButton.setTitleColor(UIColor.white, for: UIControl.State())
            searchButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            searchButton.tintColor = ColorUtils.white()
            searchButton.addTarget(self, action:#selector(NavigationControllerCustom.searchTap), for: UIControl.Event.touchUpInside)
            searchButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(searchButton)
            
            
            numberLabel = UILabel(frame: CGRect(x: widthNavi - widthButton, y: 20, width: widthButton , height: heightButton))
            numberLabel.backgroundColor = UIColor.clear
            numberLabel.textAlignment = NSTextAlignment.center
            numberLabel.font = UIFont.fontDefaultRegularSize(11.0)
            numberLabel.text = "99+"
            numberLabel.isHidden = true
            numberLabel.textColor = UIColor.yellow
            numberLabel.isUserInteractionEnabled = false
            backButton.isHidden = true
            textTitle.isHidden = true
            filterButton.isHidden = true
            addButton.isHidden = true
            contactButton.isHidden = true
            createGroupButton.isHidden = true
            menuButton.isHidden = true
            logo.isHidden = true
            logoChat.isHidden = true
            voiceButton.isHidden = true
            searchButton.isHidden = true
            search.isHidden = true
            editButton.isHidden = true
    }
    
    func setUpViewChat() {
        
            let heightNavi = self.navigationBar.frame.size.height
            let widthNavi = self.navigationBar.frame.size.width
            let statusBarSize = UIApplication.shared.statusBarFrame.size
            heightNavigationBar = heightNavi + statusBarSize.height

            self.navigationItem.hidesBackButton = true
            self.navigationBar.barTintColor = ColorUtils.main_color()
            let viewBackground = UIView(frame: CGRect(x: 0, y: -45, width: widthNavi, height: heightNavi+45))
//            viewBackground.backgroundColor = .skeletonDefault
            self.navigationBar.addSubview(viewBackground)
            
            textTitle = UILabel(frame: CGRect(x: widthNavi/2 - (widthNavi - 80)/2, y: 0, width: widthNavi - 80, height: heightNavi))
            textTitle.backgroundColor = UIColor.clear
            textTitle.textColor = UIColor.black
            textTitle.textAlignment = NSTextAlignment.center
            textTitle.font = UIFont.fontDefaultSemiBoldSize(18.0)
            textTitle.isUserInteractionEnabled = true
            self.navigationBar.addSubview(textTitle)
            
            logo = UIImageView(frame: CGRect(x: widthNavi/2 - 50, y: 5, width: 150, height: 30))
            logo.backgroundColor = UIColor.clear
            let logo_image = UIImage(named: "header_logo.png")
            logo.image = logo_image
            self.navigationBar.addSubview(logo)
        
            logoChat = UIImageView(frame: CGRect(x: 50, y: 5, width: 30, height: 30))
            logoChat.backgroundColor = UIColor.clear
            logoChat.image = UIImage(named: "header_logo.png")
            logoChat.cornerRadius = 15
            logoChat.clipsToBounds = true
            logoChat.contentMode = .scaleAspectFill
            self.navigationBar.addSubview(logoChat)
         
            search = UISearchBar(frame: CGRect(x: 10, y: 5, width: widthNavi - 120, height: 30))
            search.placeholder = "Nhập để tìm kiếm..."
            search.tintColor = .white
            search.barTintColor = .white
            self.navigationBar.addSubview(search)
            
            backButton = UIButton(frame: CGRect(x: 0.0, y: 0, width: 40, height: 40))
            backButton?.showsTouchWhenHighlighted = true
            
            if let image = UIImage(named: "icon_back") {
                backButton.setImage(image, for: .normal)
                backButton.tintColor = ColorUtils.white()
            }
            backButton.setTitleColor(UIColor.white, for: UIControl.State())
            backButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            backButton.addTarget(self, action:#selector(NavigationControllerCustom.backTap), for: UIControl.Event.touchUpInside)
            backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            backButton.tintColor = ColorUtils.main_color()
            self.navigationBar.addSubview(backButton)
        
            editButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            editButton?.showsTouchWhenHighlighted = true
            
            if let image = UIImage(named: "icon_edit") {
                editButton.setImage(image, for: .normal)
                editButton.tintColor = ColorUtils.white()
            }
            editButton.setTitleColor(UIColor.white, for: UIControl.State())
            editButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            editButton.addTarget(self, action:#selector(NavigationControllerCustom.editTap), for: UIControl.Event.touchUpInside)
            editButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            editButton.tintColor = ColorUtils.main_color()
            self.navigationBar.addSubview(editButton)
            
            addButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            addButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "icon_add") {
                addButton.setImage(image, for: .normal)
                addButton.tintColor = ColorUtils.white()
            }
            
            addButton.setTitleColor(UIColor.white, for: UIControl.State())
            addButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            addButton.addTarget(self, action:#selector(NavigationControllerCustom.addTap), for: UIControl.Event.touchUpInside)
            addButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(addButton)
        
            contactButton = UIButton(frame: CGRect(x: widthNavi - 90, y: 5, width: 30, height: 30))
            contactButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "contact") {
                contactButton.setImage(image, for: .normal)
                contactButton.tintColor = ColorUtils.white()
            }
            contactButton.setTitleColor(UIColor.white, for: UIControl.State())
            contactButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            contactButton.addTarget(self, action:#selector(NavigationControllerCustom.contactTap), for: UIControl.Event.touchUpInside)
            contactButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(contactButton)
            
            createGroupButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            createGroupButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "add-group") {
                createGroupButton.setImage(image, for: .normal)
                createGroupButton.tintColor = ColorUtils.white()
            }
            createGroupButton.setTitleColor(UIColor.white, for: UIControl.State())
            createGroupButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            createGroupButton.addTarget(self, action:#selector(NavigationControllerCustom.createGroupTap), for: UIControl.Event.touchUpInside)
            createGroupButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(createGroupButton)
        
            menuButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            menuButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "menu_button_icon") {
                menuButton.setImage(image, for: .normal)
                menuButton.tintColor = ColorUtils.main_color()
            }
            
            menuButton.setTitleColor(UIColor.white, for: UIControl.State())
            menuButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            menuButton.addTarget(self, action:#selector(NavigationControllerCustom.menuTap), for: UIControl.Event.touchUpInside)
            menuButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(menuButton)
            
            
            voiceButton = UIButton(frame: CGRect(x: 10.0, y: 0, width: 30, height: 30))
            voiceButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "icon_voice") {
                voiceButton.setImage(image, for: .normal)
                voiceButton.tintColor = ColorUtils.white()
            }
            
            voiceButton.setTitleColor(UIColor.white, for: UIControl.State())
            voiceButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            voiceButton.addTarget(self, action:#selector(NavigationControllerCustom.voiceTap), for: UIControl.Event.touchUpInside)
            voiceButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(voiceButton)
            
            
            
            filterButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            filterButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "baseline_filter_list_black_48pt") {
                filterButton.setImage(image, for: .normal)
            }
            
            filterButton.setTitleColor(UIColor.white, for: UIControl.State())
            filterButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            filterButton.tintColor = ColorUtils.white()
            filterButton.addTarget(self, action:#selector(NavigationControllerCustom.filterTap), for: UIControl.Event.touchUpInside)
            filterButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(filterButton)
            
            
            searchButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 35, height: 35))
            searchButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "icon_search") {
                searchButton.setImage(image, for: .normal)
            }
            
            searchButton.setTitleColor(UIColor.white, for: UIControl.State())
            searchButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            searchButton.tintColor = ColorUtils.white()
            searchButton.addTarget(self, action:#selector(NavigationControllerCustom.searchTap), for: UIControl.Event.touchUpInside)
            searchButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(searchButton)
            
            
            numberLabel = UILabel(frame: CGRect(x: widthNavi - widthButton, y: 20, width: widthButton , height: heightButton))
            numberLabel.backgroundColor = UIColor.clear
            numberLabel.textAlignment = NSTextAlignment.center
            numberLabel.font = UIFont.fontDefaultRegularSize(11.0)
            numberLabel.text = "99+"
            numberLabel.isHidden = true
            numberLabel.textColor = UIColor.yellow
            numberLabel.isUserInteractionEnabled = false
        
            backButton.isHidden = true
            textTitle.isHidden = true
            filterButton.isHidden = true
            addButton.isHidden = true
            contactButton.isHidden = true
            createGroupButton.isHidden = true
            menuButton.isHidden = true
            logo.isHidden = true
            logoChat.isHidden = true
            voiceButton.isHidden = true
            searchButton.isHidden = true
            search.isHidden = true
            editButton.isHidden = true
    }
    
    func setUpViewGame() {
        let heightNavi = self.navigationBar.frame.size.height
        let widthNavi = self.navigationBar.frame.size.width
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        heightNavigationBar = heightNavi + statusBarSize.height

        self.navigationItem.hidesBackButton = true
        self.navigationBar.barTintColor = ColorUtils.main_color()
        let viewBackground = UIView(frame: CGRect(x: 0, y: -45, width: widthNavi, height: heightNavi+45))
//        viewBackground.backgroundColor = .skeletonDefault
        self.navigationBar.addSubview(viewBackground)
        
        logo = UIImageView(frame: CGRect(x: widthNavi/2 - 25, y: 0, width: 45, height: 45))
        logo.backgroundColor = UIColor.clear
        let logo_image = UIImage(named: "ic-vr-gaming")
        logo.image = logo_image
        logo.contentMode = .scaleAspectFit
        self.navigationBar.addSubview(logo)
        
        backButton = UIButton(frame: CGRect(x: 0.0, y: 0, width: 40, height: 40))
        backButton?.showsTouchWhenHighlighted = true
        
        if let image = UIImage(named: "icon_back") {
            backButton.setImage(image, for: .normal)
            backButton.tintColor = ColorUtils.white()
        }
        backButton.setTitleColor(UIColor.white, for: UIControl.State())
        backButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
        backButton.addTarget(self, action:#selector(NavigationControllerCustom.backTap), for: UIControl.Event.touchUpInside)
        backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        backButton.tintColor = ColorUtils.main_color()
        self.navigationBar.addSubview(backButton)
    
        textTitle = UILabel(frame: CGRect(x: widthNavi/2 - (widthNavi - 80)/2, y: 0, width: widthNavi - 80, height: heightNavi))
        textTitle.backgroundColor = UIColor.clear
        textTitle.textColor = ColorUtils.main_color()
        textTitle.textAlignment = NSTextAlignment.center
        textTitle.font = UIFont.fontDefaultSemiBoldSize(18.0)
        textTitle.isUserInteractionEnabled = true
        self.navigationBar.addSubview(textTitle)
    
        backButton.isHidden = true
        textTitle.isHidden = true
        logo.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    func add(){
//        self.panGestureRecognizer = UIPanGestureRecognizer(target: touchTarget!, action: Selector(("handlePanGesture:")))
//        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func remove(){
//        self.view.removeGestureRecognizer(self.panGestureRecognizer)
    }
    
    func setUpNavigationBar(_ target:NavigationControllerCustomDelegate, backButton:Bool, title:String){
        
        setUpView()
        
        self.backButton.isHidden = backButton
        self.filterButton.isHidden = true
        self.addButton.isHidden = true
        self.voiceButton.isHidden = true
        self.searchButton.isHidden = true
        self.menuButton.isHidden = true
        if(title != ""){
            self.textTitle.isHidden = false
            self.textTitle.text = title
        }else{
            self.textTitle.isHidden = true
        }
       
        self.textTitle.isHidden = true
    }
    func setUpNavigationBar(_ target:NavigationControllerCustomDelegate,  backButton:Bool, logo:Bool, title:String){
        
        setUpView()
        
        self.backButton.isHidden = backButton
        self.logo.isHidden = logo
        self.filterButton.isHidden = true
        self.addButton.isHidden = true
        self.voiceButton.isHidden = true
        self.touchTarget = target
        self.searchButton.isHidden = true
        self.menuButton.isHidden = true
        if(title != ""){
            self.textTitle.isHidden = false
            self.textTitle.text = title
        }else{
            self.textTitle.isHidden = true
        }
    }
    
    func setUpNavigationBar(_ target:NavigationControllerCustomDelegate,  backButton:Bool, voiceButton:Bool, filter:Bool, add:Bool, title:String){
        setUpView()
        self.backButton.isHidden = backButton
        self.voiceButton.isHidden = voiceButton
        self.filterButton.isHidden = filter
        self.addButton.isHidden = add
        self.searchButton.isHidden = true
        self.menuButton.isHidden = true
        self.touchTarget = target
        if(title != ""){
            self.textTitle.isHidden = false
            self.textTitle.text = title
        }else{
            self.textTitle.isHidden = true
        }
    }
    
    func setUpNavigationBar(_ target:NavigationControllerCustomDelegate,  backButton:Bool, menu:Bool, title:String){
        setUpView()
        self.backButton.isHidden = backButton
        self.menuButton.isHidden = menu
        self.voiceButton.isHidden = true
        self.filterButton.isHidden = true
        self.addButton.isHidden = true
        self.searchButton.isHidden = true
        self.touchTarget = target
        if(title != ""){
            self.textTitle.isHidden = false
            self.textTitle.text = title
        }else{
            self.textTitle.isHidden = true
        }
    }
    
    func setUpNavigationBar(_ target:NavigationControllerCustomDelegate,  backButton:Bool, filter:Bool, title:String){
        
        setUpView()
        
        
        self.backButton.isHidden = backButton
        self.filterButton.isHidden = filter
        self.addButton.isHidden = true
        self.voiceButton.isHidden = true
        self.searchButton.isHidden = true
        self.menuButton.isHidden = true
        self.touchTarget = target
        if(title != ""){
            self.textTitle.isHidden = false
            self.textTitle.text = title
        }else{
            self.textTitle.isHidden = true
        }
    }
    
    func setUpNavigationBar(_ target:NavigationControllerCustomDelegate,  backButton:Bool, addButton:Bool, title:String){
        
        setUpView()
        
        self.backButton.isHidden = backButton
        self.addButton.isHidden = addButton
        self.voiceButton.isHidden = true
        self.filterButton.isHidden = true
        self.searchButton.isHidden = true
        self.menuButton.isHidden = true
        
        self.touchTarget = target
        if(title != ""){
            self.textTitle.isHidden = false
            self.textTitle.text = title
        }else{
            self.textTitle.isHidden = true
        }
    }
    
    func setUpNavigationBarGradient(_ target:NavigationControllerCustomDelegate,  backButton:Bool, addButton:Bool, title:String){
        
        setUpView()
        setUpViewGradient()
        
        self.backButton.isHidden = backButton
        self.addButton.isHidden = addButton
        self.voiceButton.isHidden = true
        self.filterButton.isHidden = true
        self.searchButton.isHidden = true
        self.menuButton.isHidden = true
        
        self.touchTarget = target
        if(title != ""){
            self.textTitle.isHidden = false
            self.textTitle.text = title
        }else{
            self.textTitle.isHidden = true
        }
    }
    
    
    
    func setUpNavigationBar(_ target:NavigationControllerCustomDelegate,  backButton:Bool, searchButton:Bool, title:String){
        
        setUpView()
        
        
        self.backButton.isHidden = backButton
        self.searchButton.isHidden = searchButton
        self.voiceButton.isHidden = true
        self.filterButton.isHidden = true
        self.addButton.isHidden = true
        self.menuButton.isHidden = true
        self.touchTarget = target
        if(title != ""){
            self.textTitle.isHidden = false
            self.textTitle.text = title
        }else{
            self.textTitle.isHidden = true
        }
    }
    
    func setUpNavigationBar(_ target:NavigationControllerCustomDelegate,  backButton:Bool, editButton:Bool, title:String){
        
        setUpView()
//        setUpViewGame()
        
        self.editButton.isHidden = editButton
        self.backButton.isHidden = backButton
//        self.searchButton.isHidden = true
        self.voiceButton.isHidden = true
        self.filterButton.isHidden = true
        self.addButton.isHidden = true
        self.menuButton.isHidden = true
        self.touchTarget = target
        if(title != ""){
            self.textTitle.isHidden = false
            self.textTitle.text = title
        }else{
            self.textTitle.isHidden = true
        }
        self.logoChat.isHidden = true
        self.logo.isHidden = true
    }
    
    func setUpNavigationBar(_ target:NavigationControllerCustomDelegate, backButton:Bool, menu: Bool, title:String, logo:Bool, logo_image: UIImage){
        
        setUpView()
        setUpViewChat()
        
        self.backButton.isHidden = backButton
        self.logoChat.isHidden = logo
        self.logoChat.image = logo_image
        self.filterButton.isHidden = true
        self.addButton.isHidden = true
        self.voiceButton.isHidden = true
        self.touchTarget = target
        self.searchButton.isHidden = true
        self.menuButton.isHidden = menu
        if(title != ""){
            self.textTitle.isHidden = false
            self.textTitle.text = title
        }else{
            self.textTitle.isHidden = true
        }
    }
    
    func setUpNavigationBar(_ target:NavigationControllerCustomDelegate,view: UISearchBarDelegate, backButton:Bool, title:String, contactButton: Bool, createGroupButton: Bool, searchBar: Bool ){
        
        setUpView()
        
        if let textfield = search.value(forKey: "searchField") as? UITextField {
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])

            textfield.textColor = UIColor.white
            textfield.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)

            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.white
            }
        }
        self.search.isHidden = searchBar
        self.search.delegate = view
        
        self.backButton.isHidden = backButton
        self.logoChat.isHidden = true
        self.filterButton.isHidden = true
        self.addButton.isHidden = true
        self.voiceButton.isHidden = true
        self.touchTarget = target
        self.searchButton.isHidden = true
        self.menuButton.isHidden = true
        self.contactButton.isHidden = contactButton
        self.createGroupButton.isHidden = createGroupButton
        
        if(title != ""){
            self.textTitle.isHidden = false
            self.textTitle.text = title
        }else{
            self.textTitle.isHidden = true
        }
    }
    
    func setUpGameNavigationBar(_ target:NavigationControllerCustomDelegate, backButton:Bool){
        setUpViewGame()
        self.search.isHidden = true
        self.backButton.isHidden = backButton
        self.logoChat.isHidden = true
        self.filterButton.isHidden = true
        self.addButton.isHidden = true
        self.voiceButton.isHidden = true
        self.touchTarget = target
        self.searchButton.isHidden = true
        self.menuButton.isHidden = true
        self.textTitle.isHidden = true
        self.logo.isHidden = false
    }
    
    //--------------------------------------------------------- Landscape -----------------------------------------------------------
    
    func setUpNavigationBarLandscape(_ target:NavigationControllerCustomDelegate, hideBackButton:Bool, title:String) {
        let heightNavi = self.navigationBar.frame.size.height
        let widthNavi = self.navigationBar.frame.size.width
        heightNavigationBar = heightNavi
               
        if backGroundView != nil {
            self.backGroundView.removeFromSuperview()
        }
        self.navigationItem.hidesBackButton = true
        self.navigationBar.barTintColor = ColorUtils.main_color()
        backGroundView = UIView(frame: CGRect(x: 0, y: -45, width: widthNavi, height: heightNavi+45))
        backGroundView.backgroundColor = ColorUtils.main_color()
        self.navigationBar.addSubview(backGroundView)
        
        textTitle = UILabel(frame: CGRect(x: widthNavi/2 - (widthNavi - 80)/2, y: 0, width: widthNavi - 80, height: heightNavi))
           textTitle.backgroundColor = UIColor.clear
           textTitle.textColor = UIColor.white
           textTitle.textAlignment = NSTextAlignment.center
           textTitle.font = UIFont.fontDefaultSemiBoldSize(18.0)
           textTitle.isUserInteractionEnabled = true
           self.navigationBar.addSubview(textTitle)
           
           logo = UIImageView(frame: CGRect(x: widthNavi/2 - 50, y: 5, width: 150, height: 30))
           logo.backgroundColor = UIColor.clear
           let logo_image = UIImage(named: "header_logo.png")
           logo.image = logo_image
           
           self.navigationBar.addSubview(logo)
           
           
           backButton = UIButton(frame: CGRect(x: 15, y: 10, width: 30, height: 30))
           backButton?.showsTouchWhenHighlighted = true
           
           if let image = UIImage(named: "icon_back") {
               backButton.setImage(image, for: .normal)
               backButton.tintColor = ColorUtils.white()
           }
           backButton.setTitleColor(UIColor.white, for: UIControl.State())
           backButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
           backButton.addTarget(self, action:#selector(NavigationControllerCustom.backTap), for: UIControl.Event.touchUpInside)
           backButton.titleEdgeInsets = UIEdgeInsets(top: -45, left: -20, bottom: 0, right: 0)
           self.navigationBar.addSubview(backButton)
           
           addButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
           addButton?.showsTouchWhenHighlighted = true
           if let image = UIImage(named: "icon_add") {
               addButton.setImage(image, for: .normal)
               addButton.tintColor = ColorUtils.white()
           }
           
           addButton.setTitleColor(UIColor.white, for: UIControl.State())
           addButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
           addButton.addTarget(self, action:#selector(NavigationControllerCustom.addTap), for: UIControl.Event.touchUpInside)
           addButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
           self.navigationBar.addSubview(addButton)
           
            menuButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            menuButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "menu_button_icon") {
                menuButton.setImage(image, for: .normal)
                menuButton.tintColor = ColorUtils.white()
            }
            
            menuButton.setTitleColor(UIColor.white, for: UIControl.State())
            menuButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            menuButton.addTarget(self, action:#selector(NavigationControllerCustom.menuTap), for: UIControl.Event.touchUpInside)
            menuButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(menuButton)
           
           voiceButton = UIButton(frame: CGRect(x: 10.0, y: 0, width: 30, height: 30))
           voiceButton?.showsTouchWhenHighlighted = true
           if let image = UIImage(named: "icon_voice") {
               voiceButton.setImage(image, for: .normal)
               voiceButton.tintColor = ColorUtils.white()
           }
           
           voiceButton.setTitleColor(UIColor.white, for: UIControl.State())
           voiceButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
           voiceButton.addTarget(self, action:#selector(NavigationControllerCustom.voiceTap), for: UIControl.Event.touchUpInside)
           voiceButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
           self.navigationBar.addSubview(voiceButton)
           
           
           
           filterButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
           filterButton?.showsTouchWhenHighlighted = true
           if let image = UIImage(named: "baseline_filter_list_black_48pt") {
               filterButton.setImage(image, for: .normal)
           }
           
           filterButton.setTitleColor(UIColor.white, for: UIControl.State())
           filterButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
           filterButton.tintColor = ColorUtils.white()
           filterButton.addTarget(self, action:#selector(NavigationControllerCustom.filterTap), for: UIControl.Event.touchUpInside)
           filterButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
           self.navigationBar.addSubview(filterButton)
           
           
           searchButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 35, height: 35))
           searchButton?.showsTouchWhenHighlighted = true
           if let image = UIImage(named: "icon_search") {
               searchButton.setImage(image, for: .normal)
           }
           
           searchButton.setTitleColor(UIColor.white, for: UIControl.State())
           searchButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
           searchButton.tintColor = ColorUtils.white()
           searchButton.addTarget(self, action:#selector(NavigationControllerCustom.searchTap), for: UIControl.Event.touchUpInside)
           searchButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
           self.navigationBar.addSubview(searchButton)
           
           
           numberLabel = UILabel(frame: CGRect(x: widthNavi - widthButton, y: 20, width: widthButton , height: heightButton))
           numberLabel.backgroundColor = UIColor.clear
           numberLabel.textAlignment = NSTextAlignment.center
           numberLabel.font = UIFont.fontDefaultRegularSize(11.0)
           numberLabel.text = "99+"
           numberLabel.isHidden = true
           numberLabel.textColor = UIColor.yellow
           numberLabel.isUserInteractionEnabled = false
           backButton.isHidden = true
           textTitle.isHidden = true
           filterButton.isHidden = true
           addButton.isHidden = true
           logo.isHidden = true
           voiceButton.isHidden = true
           searchButton.isHidden = true
        
        self.backButton.isHidden = hideBackButton
        self.logo.isHidden = true
        self.filterButton.isHidden = true
        self.addButton.isHidden = true
        self.menuButton.isHidden = true
        self.voiceButton.isHidden = true
        self.touchTarget = target
        self.searchButton.isHidden = true
        if(title != ""){
            self.textTitle.isHidden = false
            self.textTitle.text = title
        }else{
            self.textTitle.isHidden = true
        }
    }
    
    func setUpNavigationBarWithoutBackGround(_ target:NavigationControllerCustomDelegate,  isHideBackButton:Bool, isHideLogo:Bool, title:String){
        
        let heightNavi = self.navigationBar.frame.size.height
        let widthNavi = self.navigationBar.frame.size.width
        heightNavigationBar = heightNavi
        
        
        if backGroundView != nil {
            self.backGroundView.removeFromSuperview()
        }
        
        self.navigationItem.hidesBackButton = true
        self.navigationBar.barTintColor = ColorUtils.main_color()
        backGroundView = UIView(frame: CGRect(x: 0, y: -45, width: widthNavi, height: heightNavi+45))
        backGroundView.backgroundColor = ColorUtils.main_color()
        self.navigationBar.addSubview(backGroundView)
        
        textTitle = UILabel(frame: CGRect(x: widthNavi/2 - (widthNavi - 80)/2, y: 0, width: widthNavi - 80, height: heightNavi))
           textTitle.backgroundColor = UIColor.clear
           textTitle.textColor = UIColor.white
           textTitle.textAlignment = NSTextAlignment.center
           textTitle.font = UIFont.fontDefaultSemiBoldSize(18.0)
           textTitle.isUserInteractionEnabled = true
           self.navigationBar.addSubview(textTitle)
           
           logo = UIImageView(frame: CGRect(x: widthNavi/2 - 50, y: 5, width: 150, height: 30))
           logo.backgroundColor = UIColor.clear
           let logo_image = UIImage(named: "header_logo.png")
           logo.image = logo_image
           
           self.navigationBar.addSubview(logo)
        
          let search = UISearchBar(frame: CGRect(x: widthNavi/2 - 50, y: 5, width: 150, height: 30))
           self.navigationController?.searchDisplayController?.displaysSearchBarInNavigationBar = true
           
           
           backButton = UIButton(frame: CGRect(x: 0.0, y: 0, width: 40, height: 40))
           backButton?.showsTouchWhenHighlighted = true
           
           if let image = UIImage(named: "icon_back") {
               backButton.setImage(image, for: .normal)
               backButton.tintColor = ColorUtils.white()
           }
           backButton.setTitleColor(UIColor.white, for: UIControl.State())
           backButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
           backButton.addTarget(self, action:#selector(NavigationControllerCustom.backTap), for: UIControl.Event.touchUpInside)
           backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
           self.navigationBar.addSubview(backButton)
           
           addButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
           addButton?.showsTouchWhenHighlighted = true
           if let image = UIImage(named: "icon_add") {
               addButton.setImage(image, for: .normal)
               addButton.tintColor = ColorUtils.white()
           }
           
           addButton.setTitleColor(UIColor.white, for: UIControl.State())
           addButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
           addButton.addTarget(self, action:#selector(NavigationControllerCustom.addTap), for: UIControl.Event.touchUpInside)
           addButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
           self.navigationBar.addSubview(addButton)
           
            menuButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
           menuButton?.showsTouchWhenHighlighted = true
           if let image = UIImage(named: "menu_button_icon") {
               menuButton.setImage(image, for: .normal)
               menuButton.tintColor = ColorUtils.white()
           }
           
           menuButton.setTitleColor(UIColor.white, for: UIControl.State())
           menuButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
           menuButton.addTarget(self, action:#selector(NavigationControllerCustom.menuTap), for: UIControl.Event.touchUpInside)
           menuButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
           self.navigationBar.addSubview(menuButton)
           
           voiceButton = UIButton(frame: CGRect(x: 10.0, y: 0, width: 30, height: 30))
           voiceButton?.showsTouchWhenHighlighted = true
           if let image = UIImage(named: "icon_voice") {
               voiceButton.setImage(image, for: .normal)
               voiceButton.tintColor = ColorUtils.white()
           }
           
           voiceButton.setTitleColor(UIColor.white, for: UIControl.State())
           voiceButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
           voiceButton.addTarget(self, action:#selector(NavigationControllerCustom.voiceTap), for: UIControl.Event.touchUpInside)
           voiceButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
           self.navigationBar.addSubview(voiceButton)
           
           
           
           filterButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
           filterButton?.showsTouchWhenHighlighted = true
           if let image = UIImage(named: "baseline_filter_list_black_48pt") {
               filterButton.setImage(image, for: .normal)
           }
           
           filterButton.setTitleColor(UIColor.white, for: UIControl.State())
           filterButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
           filterButton.tintColor = ColorUtils.white()
           filterButton.addTarget(self, action:#selector(NavigationControllerCustom.filterTap), for: UIControl.Event.touchUpInside)
           filterButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
           self.navigationBar.addSubview(filterButton)
           
           
           searchButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 35, height: 35))
           searchButton?.showsTouchWhenHighlighted = true
           if let image = UIImage(named: "icon_search") {
               searchButton.setImage(image, for: .normal)
           }
           
           searchButton.setTitleColor(UIColor.white, for: UIControl.State())
           searchButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
           searchButton.tintColor = ColorUtils.white()
           searchButton.addTarget(self, action:#selector(NavigationControllerCustom.searchTap), for: UIControl.Event.touchUpInside)
           searchButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
           self.navigationBar.addSubview(searchButton)
           
           
           numberLabel = UILabel(frame: CGRect(x: widthNavi - widthButton, y: 20, width: widthButton , height: heightButton))
           numberLabel.backgroundColor = UIColor.clear
           numberLabel.textAlignment = NSTextAlignment.center
           numberLabel.font = UIFont.fontDefaultRegularSize(11.0)
           numberLabel.text = "99+"
           numberLabel.isHidden = true
           numberLabel.textColor = UIColor.yellow
           numberLabel.isUserInteractionEnabled = false
           backButton.isHidden = true
           textTitle.isHidden = true
           filterButton.isHidden = true
           addButton.isHidden = true
           logo.isHidden = true
           voiceButton.isHidden = true
           searchButton.isHidden = true
        
        textTitle = UILabel(frame: CGRect(x: widthNavi/2 - (widthNavi - 80)/2, y: 0, width: widthNavi - 80, height: heightNavi))
           textTitle.backgroundColor = UIColor.clear
           textTitle.textColor = UIColor.white
           textTitle.textAlignment = NSTextAlignment.center
           textTitle.font = UIFont.fontDefaultSemiBoldSize(18.0)
           textTitle.isUserInteractionEnabled = true
           self.navigationBar.addSubview(textTitle)
           
           logo = UIImageView(frame: CGRect(x: widthNavi/2 - 50, y: 5, width: 150, height: 30))
           logo.backgroundColor = UIColor.clear
           logo.image = logo_image
           
           self.navigationBar.addSubview(logo)
        
           self.navigationController?.searchDisplayController?.displaysSearchBarInNavigationBar = true
           
           
           backButton = UIButton(frame: CGRect(x: 0.0, y: 0, width: 40, height: 40))
           backButton?.showsTouchWhenHighlighted = true
           
           if let image = UIImage(named: "icon_back") {
               backButton.setImage(image, for: .normal)
               backButton.tintColor = ColorUtils.white()
           }
           backButton.setTitleColor(UIColor.white, for: UIControl.State())
           backButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
           backButton.addTarget(self, action:#selector(NavigationControllerCustom.backTap), for: UIControl.Event.touchUpInside)
           backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
           self.navigationBar.addSubview(backButton)
           
           addButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
           addButton?.showsTouchWhenHighlighted = true
           if let image = UIImage(named: "icon_add") {
               addButton.setImage(image, for: .normal)
               addButton.tintColor = ColorUtils.white()
           }
           
           addButton.setTitleColor(UIColor.white, for: UIControl.State())
           addButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
           addButton.addTarget(self, action:#selector(NavigationControllerCustom.addTap), for: UIControl.Event.touchUpInside)
           addButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
           self.navigationBar.addSubview(addButton)
           
            menuButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
            menuButton?.showsTouchWhenHighlighted = true
            if let image = UIImage(named: "menu_button_icon") {
                menuButton.setImage(image, for: .normal)
                menuButton.tintColor = ColorUtils.white()
            }
            
            menuButton.setTitleColor(UIColor.white, for: UIControl.State())
            menuButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
            menuButton.addTarget(self, action:#selector(NavigationControllerCustom.menuTap), for: UIControl.Event.touchUpInside)
            menuButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            self.navigationBar.addSubview(menuButton)
           
           voiceButton = UIButton(frame: CGRect(x: 10.0, y: 0, width: 30, height: 30))
           voiceButton?.showsTouchWhenHighlighted = true
           if let image = UIImage(named: "icon_voice") {
               voiceButton.setImage(image, for: .normal)
               voiceButton.tintColor = ColorUtils.white()
           }
           
           voiceButton.setTitleColor(UIColor.white, for: UIControl.State())
           voiceButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
           voiceButton.addTarget(self, action:#selector(NavigationControllerCustom.voiceTap), for: UIControl.Event.touchUpInside)
           voiceButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
           self.navigationBar.addSubview(voiceButton)
           
           
           
           filterButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 40, height: 40))
           filterButton?.showsTouchWhenHighlighted = true
           if let image = UIImage(named: "baseline_filter_list_black_48pt") {
               filterButton.setImage(image, for: .normal)
           }
           
           filterButton.setTitleColor(UIColor.white, for: UIControl.State())
           filterButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
           filterButton.tintColor = ColorUtils.white()
           filterButton.addTarget(self, action:#selector(NavigationControllerCustom.filterTap), for: UIControl.Event.touchUpInside)
           filterButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
           self.navigationBar.addSubview(filterButton)
           
           
           searchButton = UIButton(frame: CGRect(x: widthNavi - 50, y: 0, width: 35, height: 35))
           searchButton?.showsTouchWhenHighlighted = true
           if let image = UIImage(named: "icon_search") {
               searchButton.setImage(image, for: .normal)
           }
           
           searchButton.setTitleColor(UIColor.white, for: UIControl.State())
           searchButton.setTitleColor(UIColor.COLOR_ICON_TOUCH(), for: UIControl.State.highlighted)
           searchButton.tintColor = ColorUtils.white()
           searchButton.addTarget(self, action:#selector(NavigationControllerCustom.searchTap), for: UIControl.Event.touchUpInside)
           searchButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
           self.navigationBar.addSubview(searchButton)
           
           
           numberLabel = UILabel(frame: CGRect(x: widthNavi - widthButton, y: 20, width: widthButton , height: heightButton))
           numberLabel.backgroundColor = UIColor.clear
           numberLabel.textAlignment = NSTextAlignment.center
           numberLabel.font = UIFont.fontDefaultRegularSize(11.0)
           numberLabel.text = "99+"
           numberLabel.isHidden = true
           numberLabel.textColor = UIColor.yellow
           numberLabel.isUserInteractionEnabled = false
           backButton.isHidden = true
           textTitle.isHidden = true
           filterButton.isHidden = true
           addButton.isHidden = true
           logo.isHidden = true
           voiceButton.isHidden = true
           searchButton.isHidden = true
        
        self.backButton.isHidden = isHideBackButton
        self.logo.isHidden = true
        self.filterButton.isHidden = true
        self.addButton.isHidden = true
        self.menuButton.isHidden = true
        self.voiceButton.isHidden = true
        self.touchTarget = target
        self.searchButton.isHidden = true
        if(title != ""){
            self.textTitle.isHidden = false
            self.textTitle.text = title
        }else{
            self.textTitle.isHidden = true
        }
    }
    
    
    //--------------------------------------------------------- Landscape -----------------------------------------------------------
    
    
    func setTitleHeader(_ title : String){
        if(title != ""){
            self.textTitle.isHidden = false
            self.textTitle.text = title
        }else{
            self.textTitle.isHidden = true
        }
    }
    
    func showNotification(){
        
        if(self.isMenuHidden){
            self.labelNotification!.isHidden = true
        }
        else{
            if(UserDefaults.standard.bool(forKey: "ShowNotification")){
                self.labelNotification!.isHidden = false
//                self.labelNotification.text = String(format : "%d",UIApplication.shared.applicationIconBadgeNumber)
            }
        }
    }
    func navigationController(_ navigationController: UINavigationController, willShow: UIViewController, animated: Bool){
    
    }
  
   @objc func backTap(){
        debugPrint("back Tap")
        touchTarget?.backTap!()
    }
    
    @objc func editTap(){
        debugPrint("edit Tap")
        touchTarget?.editTap!()
    }

    @objc func actionTap(){
        debugPrint("action Tap")
        touchTarget?.actionTap!()
    }
    
    @objc func voiceTap(){
        debugPrint("voice Tap")
        touchTarget?.voiceTap!()
    }
    
    @objc func filterTap(){
        debugPrint("filter Tap")
        touchTarget?.filterTap!()
    }
    
    @objc func addTap(){
        debugPrint("add Tap")
        touchTarget?.addTap!()
    }
    
    @objc func menuTap(){
        debugPrint("menu Tap")
        touchTarget?.menuTap!()
    }
    
    @objc func searchTap(){
        debugPrint("search Tap")
        touchTarget?.searchTap!()
    }
    
    @objc func contactTap(){
        debugPrint("contact Tap")
        touchTarget?.contactTap!()
    }
    
    @objc func createGroupTap(){
        debugPrint("create group Tap")
        touchTarget?.createGroupTap!()
    }
}
