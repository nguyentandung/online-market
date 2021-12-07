//
//  StoryboardManager.swift
//  Techres-Customer
//
//  Created by kelvin on 11/04/2021.
//  Copyright © 2020 aloapp. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
//    ============== define Main Storyboard ===============
    
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
        }

    class func viewController() -> ViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "ViewController") as? ViewController
        }
                                          
    class func accountViewController() -> AccountViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "AccountViewController") as? AccountViewController
        }
    
    class func mainViewController() -> MainViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
        }
    
    class func chatMessageViewController() -> ChatMessageViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "ChatMessageViewController") as? ChatMessageViewController
        }
    
    
    class func homeViewController() -> HomeViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        }
    
    
    class func createNewFeedViewController() -> CreateNewFeedViewController? {
        
        return mainStoryboard().instantiateViewController(withIdentifier: "CreateNewFeedViewController") as? CreateNewFeedViewController
        
    }

 
    //    ============== define Intro Storyboard ===============
    class func introStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Introduction", bundle: Bundle.main)
        }
    
    
    class func onBoardViewController() -> OnBoardViewController? {
        return introStoryboard().instantiateViewController(withIdentifier: "OnBoardViewController") as? OnBoardViewController
        }
    
    
    
    //    ============== define Account Storyboard ===============
        
        class func accountStoryboard() -> UIStoryboard {
            return UIStoryboard(name: "Account", bundle: Bundle.main)
        }
       
        class func forgotPasswordViewController() -> ForgotPasswordViewController? {
    return accountStoryboard().instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController
        }
   
    class func forgotResetPasswordViewController() -> ForgotResetPasswordViewController? {
        return accountStoryboard().instantiateViewController(withIdentifier: "ForgotResetPasswordViewController") as? ForgotResetPasswordViewController
        }
    
    class func loginViewController() -> LoginViewController? {
       return accountStoryboard().instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
    }
    
    class func changePassWordViewController() -> ChangePassWordViewController? {
        return accountStoryboard().instantiateViewController(withIdentifier: "ChangePassWordViewController") as? ChangePassWordViewController
        }
    
    class func registerViewController() -> RegisterViewController? {
        return accountStoryboard().instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        }
    
    class func registerInformationViewController() -> RegisterInformationViewController? {
        return accountStoryboard().instantiateViewController(withIdentifier: "RegisterInformationViewController") as? RegisterInformationViewController
        }
    
    class func changeAvatarViewController() -> ChangeAvatarViewController? {
        return accountStoryboard().instantiateViewController(withIdentifier: "ChangeAvatarViewController") as? ChangeAvatarViewController
        }
    
    //    ============== define Setting Storyboard ===============
    
    class func settingStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Setting", bundle: Bundle.main)
        }
    
    class func settingViewController() -> SettingViewController? {
    return settingStoryboard().instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController
        }

    class func languageViewController() -> LanguageViewController? {
    return settingStoryboard().instantiateViewController(withIdentifier: "LanguageViewController") as? LanguageViewController
        }


    
    //    ============== define Profile Storyboard ===============
    class func profileStoryboard() -> UIStoryboard {
       return UIStoryboard(name: "Profile", bundle: Bundle.main)
       }
    
    
    class func profileUserViewController() -> ProfileUserViewController? {
       return profileStoryboard().instantiateViewController(withIdentifier: "ProfileUserViewController") as? ProfileUserViewController
    }
    class func editProfileUserViewController() -> EditProfileUserViewController? {
       return profileStoryboard().instantiateViewController(withIdentifier: "EditProfileUserViewController") as? EditProfileUserViewController
    }
    
    
    
    
    //MARK:define Login Storyboard
    
   
    //MARK:define CreatePost Storyboard
    
    class func createPostStoryboard() -> UIStoryboard {
       return UIStoryboard(name: "CreatePost", bundle: Bundle.main)
       }
    
    
    class func createTransportViewController() -> CreateTransportViewController? {
       return createPostStoryboard().instantiateViewController(withIdentifier: "CreateTransportViewController") as? CreateTransportViewController
    }
    
    
    class func createTechViewController() -> CreateTechViewController? {
       return createPostStoryboard().instantiateViewController(withIdentifier: "CreateTechViewController") as? CreateTechViewController
    }
    
    class func createMotoCycleViewController() -> CreateMotoCycleViewController? {
       return createPostStoryboard().instantiateViewController(withIdentifier: "CreateMotoCycleViewController") as? CreateMotoCycleViewController
    }
    
    class func createBikeViewController() -> CreateBikeViewController? {
       return createPostStoryboard().instantiateViewController(withIdentifier: "CreateBikeViewController") as? CreateBikeViewController
    }
    
    
    //MARK:define Home Storyboard
    
    class func detailNewfeedStoryboard() -> UIStoryboard {
       return UIStoryboard(name: "Home", bundle: Bundle.main)
       }
    
    class func detailTransportViewController() -> DetailTransportViewController? {
       return detailNewfeedStoryboard().instantiateViewController(withIdentifier: "DetailTransportViewController") as? DetailTransportViewController
    }
    
    class func searchViewController() -> SearchViewController? {
       return detailNewfeedStoryboard().instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
    }
    
    //MARK:define SetInformation Storyboard
    
    class func setInformationStoryboard() -> UIStoryboard {
       return UIStoryboard(name: "SetInformation", bundle: Bundle.main)
       }
    
    class func techInforViewController() -> TechInforViewController? {
       return setInformationStoryboard().instantiateViewController(withIdentifier: "TechInforViewController") as? TechInforViewController
    }
    
    class func transportInforViewController() -> TransportInforViewController? {
       return setInformationStoryboard().instantiateViewController(withIdentifier: "TransportInforViewController") as? TransportInforViewController
    }
    
    //MARK:define ChooseTypePost Storyboard
    
    class func chooseTypePostStoryboard() -> UIStoryboard {
       return UIStoryboard(name: "ChooseTypePost", bundle: Bundle.main)
       }
    
    class func chooseTypeTranSportViewController() -> ChooseTypeTranSportViewController? {
       return chooseTypePostStoryboard().instantiateViewController(withIdentifier: "ChooseTypeTranSportViewController") as? ChooseTypeTranSportViewController
    }
    
    class func chooseTypeTechViewController() -> ChooseTypeTechViewController? {
       return chooseTypePostStoryboard().instantiateViewController(withIdentifier: "ChooseTypeTechViewController") as? ChooseTypeTechViewController
    }
    
    
    //MARK:define SetData Storyboard
    
    class func setDataStoryboard() -> UIStoryboard {
       return UIStoryboard(name: "SetData", bundle: Bundle.main)
       }
    
    class func brandViewController() -> BrandViewController? {
       return setDataStoryboard().instantiateViewController(withIdentifier: "BrandViewController") as? BrandViewController
    }
    
    //MARK:define SetData Storyboard
    
    class func listNewFeedStoryboard() -> UIStoryboard {
       return UIStoryboard(name: "ListNewFeed", bundle: Bundle.main)
       }
    
    class func listTechnologyViewController() -> ListTechnologyViewController? {
       return listNewFeedStoryboard().instantiateViewController(withIdentifier: "ListTechnologyViewController") as? ListTechnologyViewController
    }
    
    class func listCarViewController() -> ListCarViewController? {
       return listNewFeedStoryboard().instantiateViewController(withIdentifier: "ListCarViewController") as? ListCarViewController
    }
    
    class func allTranSportViewController() -> AllTranSportViewController? {
       return listNewFeedStoryboard().instantiateViewController(withIdentifier: "AllTranSportViewController") as? AllTranSportViewController
    }
    
    class func ListMotoCycleViewController() -> ListMotoCycleViewController? {
       return listNewFeedStoryboard().instantiateViewController(withIdentifier: "ListMotoCycleViewController") as? ListMotoCycleViewController
    }
    
    
    //MARK:define Chat Storyboard
    
    class func chatStoryboard() -> UIStoryboard {
       return UIStoryboard(name: "Chat", bundle: Bundle.main)
       }
    
    class func chatTwoUserViewController() -> ChatTwoUserViewController? {
       return chatStoryboard().instantiateViewController(withIdentifier: "ChatTwoUserViewController") as? ChatTwoUserViewController
    }
    
    
}


