//
//  ManageCacheObject.swift
//  TechresSupplier (iOS)
//
//  Created by KELVIN on 06/04/2021.
//

import UIKit

import ObjectMapper

class ManageCacheObject: NSObject {
    
    // MARK: - setFistRun
    static func setFirstRun(_ first_run:Bool){
        UserDefaults.standard.set(first_run, forKey:KEY_FIRST_RUN)
    }
    
    static func getFirstRun()->Bool{
        if let first_run : Bool = UserDefaults.standard.object(forKey: KEY_FIRST_RUN) as? Bool{
            return first_run
        }else{
            return false
        }
    }
    
    // MARK: - setConfig
    static func setSetting(_ setting: Settings){
        UserDefaults.standard.set(Mapper<Settings>().toJSON(setting), forKey:KEY_SETTING)
    }
    
    static func getSettings() -> Settings{
        if let settings  = UserDefaults.standard.object(forKey: KEY_SETTING){
            return Mapper<Settings>().map(JSONObject: settings)!
        }else{
            return Settings()
        }
    }
    
    static func saveCurrentAccount(_ account : Account) {
        UserDefaults.standard.set(Mapper<Account>().toJSON(account), forKey:KEY_ACCOUNT)
    }
    
    
    static func getCurrentAccount() -> Account{
        if let userJson = UserDefaults.standard.object(forKey: KEY_ACCOUNT){
            let user : Account = Mapper<Account>().map(JSONObject: userJson)!
            return user
        }else
        {
            let account = Account()
            return account
        }
    }
    
//    static func getCurrentAccount() -> Account{
//        let user : User = Mapper<User>().map(JSONObject: User())!
//    }
//
    
    static func saveToken(token:String){
        
    }
    
    static func gettoken() -> String{
        return ""
    }
    
//    static func isLogin(islogin:Bool) -> Bool {
//        
//        return islogin
//    }
    
    
    static func isLogin()->Bool{
        let account = ManageCacheObject.getCurrentAccount()
        if(account._id == ""){
     
       return false

        }
        return true
    }
    
    static func clearUser(){
        UserDefaults.standard.set(nil, forKey: KEY_ACCOUNT)
        UserDefaults.standard.set(nil, forKey: KEY_GAME_ACCOUNT)
    }
    
    
    //MARK: Save history
    
    static func setTypeSearch(_ prioritize_type:Int){
        UserDefaults.standard.set(prioritize_type, forKey:KEY_HISTORY)
    }
    
    static func getPrioritizeType()->Int{
        if let prioritize_type : Int = UserDefaults.standard.object(forKey: KEY_HISTORY) as? Int{
            
            return prioritize_type
        }else{
            return -1
        }
    }
    
    
    
    // MARK: - Token
    static func setToken(_ token:String){
        UserDefaults.standard.set(token, forKey:KEY_TOKEN)
    }
    
    static func getToken()->String{
        if let token : String = UserDefaults.standard.object(forKey: KEY_TOKEN) as? String{
            //            debugPrint(String(token as! String), terminator: "")
            return token
        }else{
            return ""
        }
    }
    // MARK: - Push Token
    static func setPush_Token(_ push_token:String){
        UserDefaults.standard.set(push_token, forKey:KEY_PUSH_TOKEN)
    }
    
    static func getPush_Token()->String{
         if let push_token  = UserDefaults.standard.object(forKey: KEY_PUSH_TOKEN){
            debugPrint(String(push_token as! String), terminator: "")
            return String(push_token as! String)
         }else{
            return ""
         }
 
    }
    
    // MARK: - setFistRun
    static func setFistRun(_ firt_run:Bool){
        UserDefaults.standard.set(firt_run, forKey:KEY_FIRT_RUN)
    }
    
    static func getFistRun()->Bool{
        if let firt_run : Bool = UserDefaults.standard.object(forKey: KEY_FIRT_RUN) as? Bool{
            return firt_run
        }else{
            return true
        }
    }
    // MARK: - setConfig
    static func setConfig(_ config: GeneralConfigs){
        UserDefaults.standard.set(Mapper<GeneralConfigs>().toJSON(config), forKey:KEY_CONFIG)
    }
    
    static func getConfig() -> GeneralConfigs {
        if let generalConfigs  = UserDefaults.standard.object(forKey: KEY_CONFIG){
            return Mapper<GeneralConfigs>().map(JSONObject: generalConfigs)!
        }else{
            return GeneralConfigs()
        }
    }
    
}
