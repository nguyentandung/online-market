//
//  ResAPI.swift
//  VNMarket
//
//  Created by Nguyen Tan Dung on 04/07/21.
//

import Foundation
import Alamofire
import ObjectMapper
import ReachabilitySwift
import SystemConfiguration

class ResAPI: UIResponder {
    let POST = true
    let GET = false
    
    var alamofireManager : SessionManager!
    
    
    //1
    class var sharedInstance: ResAPI {
        //2
        struct Singleton {
            //3
            static let instance = ResAPI()
        }
        //4
        return Singleton.instance
    }
    
    override init() {
        super.init()
    }
    
    
    func checkInternet() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
//    MARK: Check error service
    func checkErrorService(data:AnyObject?,error : String?)->(data:AnyObject?, Message : String){
        if(data == nil && error == nil){
            return (nil,"")
        }else if (data == nil && error != nil){
            return (data,"")
        }else{
            return (data, "")
        }
    }
    
    //MARK: POST METHOD CALL API
    func callServiceWithPOSTMethod(params : Dictionary<String, AnyObject>, url : String, postCompleted : @escaping (_ data:AnyObject?, _ statusCode: Int?) -> ()){
        
//        var auth_header = ["Authorization": "Bearer \(ManageCacheObject.getCurrentAccount().access_token)"]
        var auth_header = ["Authorization": "Bearer \(ManageCacheObject.getCurrentAccount().accessToken)"]
        
        auth_header = ManageCacheObject.isLogin() ? ["Authorization": "Bearer \(ManageCacheObject.getCurrentAccount().accessToken)"] : ["Authorization": "Basic \(ManageCacheObject.getToken())"]
        
        debugPrint(url,params,auth_header)
        Alamofire.request(url, method: .post, parameters: params,  encoding: JSONEncoding.default, headers: auth_header).responseJSON { response in
            switch response.result {
            case .success:
                debugPrint(response.result)
                return postCompleted(response.result.value as AnyObject?, response.response?.statusCode)
            case .failure( _):
                return postCompleted(nil, response.response?.statusCode)
            }
        }
        
    }
    
    //MARK: GET METHOD CALL API
    func callServiceWithGETMethod(params : Dictionary<String, AnyObject>, url : String, postCompleted : @escaping (_ data:AnyObject?, _ statusCode: Int?) -> ()){
        
        var auth_header = ["Authorization": "Bearer \(ManageCacheObject.getCurrentAccount().accessToken)"]
        
        auth_header = ManageCacheObject.isLogin() ? ["Authorization": "Bearer \(ManageCacheObject.getCurrentAccount().accessToken)"] : ["Authorization": "Basic \(ManageCacheObject.getToken())"]
        
        debugPrint(url,params,auth_header)
        Alamofire.request(url, method:.get, parameters: params, encoding: URLEncoding.default, headers: auth_header).responseJSON { response in
            
            debugPrint("Request  \(String(describing: response.request))")
            
            debugPrint("RESPONSE \(String(describing: response.result.value))")
            debugPrint(response.result)
            
            switch response.result {
            case .success:
                
                return postCompleted(response.result.value as AnyObject?, response.response?.statusCode)
                
            case .failure( _):
                return postCompleted(nil, response.response?.statusCode)
            }
        }
        
    }
    
    //MARK:checkOnlineCallServiceWithMethod
    func checkOnlineCallServiceWithMethod(params : NSDictionary?,files: NSDictionary? = nil, url : String, postMethod : Bool, postCompleted : @escaping (_ data:AnyObject?,_ error :String) -> ()){
        var parseParams : Dictionary<String, AnyObject>? = params as? Dictionary<String, AnyObject>
        if(parseParams == nil){
            parseParams = Dictionary<String, AnyObject>()
        }
        parseParams?.updateValue("party_ios" as AnyObject, forKey: "os_name")
        
        if self.checkInternet() {
            if(postMethod){
                self.callServiceWithPOSTMethod(params: parseParams!, url: url, postCompleted: { (data, statusCode) -> () in
                    if(statusCode == STATUS_REQUEST.STATUS_SUCCESS.rawValue){// code successs
                        if(data != nil){
                            let response:ResResponse = Mapper<ResResponse>().map(JSONObject: data)!
                            if(response.code == 401){
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ERROR_UNAUTHORIZED"), object: nil)
                            }else if(response.code == 411){
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ERROR_UNAUTHORIZED"), object: nil)
                            }else{
                                let completeData = self.checkErrorService(data: response, error: "")
                                return postCompleted(completeData.0, completeData.1)
                            }
                            
                        }else{
                            let completeData = self.checkErrorService(data: nil, error: "")
                            return postCompleted(completeData.0, completeData.1)
                        }
                        
                    }else if(statusCode == 411){
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ERROR_UNAUTHORIZED"), object: nil)
                    }else{
                        let completeData = self.checkErrorService(data: nil, error: "")
                        return postCompleted(completeData.0, completeData.1)
                    }
                })
            }else{
                self.callServiceWithGETMethod(params: parseParams!, url: url,  postCompleted: { (data, statusCode) -> () in
                    
                    if(statusCode == STATUS_REQUEST.STATUS_SUCCESS.rawValue){// code successs
                        if(data != nil){
                            let response:ResResponse = Mapper<ResResponse>().map(JSONObject: data)!
                            if(response.code == 401){
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ERROR_UNAUTHORIZED"), object: nil)
                            }else if(response.code == 411){
                                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ERROR_UNAUTHORIZED"), object: nil)
                            }else{
                                let completeData = self.checkErrorService(data: response, error: "")
                                return postCompleted(completeData.0, completeData.1)
                            }
                        }else{
                            let completeData = self.checkErrorService(data: nil, error: "")
                            return postCompleted(completeData.0, completeData.1)
                        }
                    }else if(statusCode == 411){
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ERROR_UNAUTHORIZED"), object: nil)
                    }
                    else{
                        let completeData = self.checkErrorService(data: nil, error: "")
                        return postCompleted(completeData.0, completeData.1)
                    }
                })
            }
            
        }else{
            let completeData = self.checkErrorService(data: nil, error: nil)
            return postCompleted(completeData.0, completeData.1)
        }
        
    }
    
    //MARK: POST
    
    
    func phoneLogin(email:String, password:String, _ callBack: @escaping (_ data : AnyObject? , _ Message : String?)->Void) ->Void{
            
        let url: String  = DEFAULT_MAIN_DOMAIN + String(format: API_LOGIN)
        
        debugPrint(url)
        
        
        let params = [
            "email":email,
            "password":password
            ] as [String : Any]
        
        checkOnlineCallServiceWithMethod(params: params as NSDictionary , url: url, postMethod : POST) { (data, error) -> () in
            return callBack(data, error)
        }
    }
    
    func registerAccount(email:String, first_name:String,last_name:String,gender:Int,address:String,password:String, _ callBack: @escaping (_ data : AnyObject? , _ Message : String?)->Void) ->Void{
            
        let url: String  = DEFAULT_MAIN_DOMAIN + String(format: API_REGISTER)
        
        debugPrint(url)
        
        
        let params = [
            "email":email,
            "first_name":first_name,
            "last_name": last_name,
            "gender":gender,
            "address":address,
            "password":password
           
            ] as [String : Any]
        
        checkOnlineCallServiceWithMethod(params: params as NSDictionary , url: url, postMethod : POST) { (data, error) -> () in
            return callBack(data, error)
        }
    }
    
    func postNewfeed(postObject:CarPostNewfeed, _ callBack: @escaping (_ data : AnyObject? , _ Message : String?)->Void) ->Void{
            
        let url: String  = DEFAULT_MAIN_DOMAIN + String(format: API_POST)
        
        debugPrint(url)
        
        
        let params = postObject.toJSON() as [String : Any]
        
        checkOnlineCallServiceWithMethod(params: params as NSDictionary , url: url, postMethod : POST) { (data, error) -> () in
            return callBack(data, error)
        }
    }
    
    func uploadPhoto(image: String,callBack:@escaping (_ data:AnyObject?,_ Message : String?)->Void) ->Void{
        let url: String = DEFAULT_MAIN_DOMAIN + API_UPLOAD_LINKIMAGE
        var params = [
            "image": image,
            ] as [String : Any]
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            params["ver"] = version
        }
        debugPrint(params)
        checkOnlineCallServiceWithMethod(params: params as NSDictionary? , url: url, postMethod : POST) { (data, error) -> () in
            return callBack(data, error)
        }
    }
    
    
    func createGroupChat(user_first_id: String,user_second_id:String,user_first_name:String,user_second_name:String,callBack:@escaping (_ data:AnyObject?,_ Message : String?)->Void) ->Void{
        let url: String = DEFAULT_MAIN_DOMAIN + API_CREATE_GROUPCHAT
        var params = [
            "user_first_id": user_first_id,
            "user_second_id":user_second_id,
            "user_first_name": user_first_name,
            "user_second_name":user_second_name
            ] as [String : Any]
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            params["ver"] = version
        }
        debugPrint(params)
        checkOnlineCallServiceWithMethod(params: params as NSDictionary? , url: url, postMethod : POST) { (data, error) -> () in
            return callBack(data, error)
        }
    }
    
    func updateAvatar(avatar_image: String,callBack:@escaping (_ data:AnyObject?,_ Message : String?)->Void) ->Void{
        let url: String = DEFAULT_MAIN_DOMAIN + API_UPDATE_AVATAR
        var params = [
            "avatar_image":avatar_image
            ] as [String : Any]
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            params["ver"] = version
        }
        debugPrint(params)
        checkOnlineCallServiceWithMethod(params: params as NSDictionary? , url: url, postMethod : POST) { (data, error) -> () in
            return callBack(data, error)
        }
    }

    
    //MARK: GET
    
    func getNewFeed(page:Int,limit:Int,type:Int,prioritize_type:Int, _ callBack: @escaping (_ data : AnyObject? , _ Message : String?)->Void) ->Void{
            
        let url: String  = DEFAULT_MAIN_DOMAIN + String(format: API_GET_NEWFEED,prioritize_type)
        
        debugPrint(url)
        
        let params = [
            "page" : page,
            "limit" : limit,
            "type":type
            
            ] as [String : Any]
        
        checkOnlineCallServiceWithMethod(params: params as NSDictionary , url: url, postMethod : GET) { (data, error) -> () in
            return callBack(data, error)
        }
    }
    
    func getLinkImage(file_name:String, _ callBack: @escaping (_ data : AnyObject? , _ Message : String?)->Void) ->Void{
            
        let url: String  = DEFAULT_MAIN_DOMAIN + String(format: API_GET_LINK)
        
        debugPrint(url)
        
        let params = [
            "file_name" : file_name
            ] as [String : Any]
        
        checkOnlineCallServiceWithMethod(params: params as NSDictionary , url: url, postMethod : GET) { (data, error) -> () in
            return callBack(data, error)
        }
    }
    
    func getInforUser(_id:String, _ callBack: @escaping (_ data : AnyObject? , _ Message : String?)->Void) ->Void{
            
        let url: String  = DEFAULT_MAIN_DOMAIN + String(format: API_GET_INFORMATION)
        
        debugPrint(url)
        
        let params = [
            "_id" : _id
            ] as [String : Any]
        
        checkOnlineCallServiceWithMethod(params: params as NSDictionary , url: url, postMethod : GET) { (data, error) -> () in
            return callBack(data, error)
        }
    }
    
    func getMyPost(_id:String, _ callBack: @escaping (_ data : AnyObject? , _ Message : String?)->Void) ->Void{
            
        let url: String  = DEFAULT_MAIN_DOMAIN + String(format: API_GET_MY_POST)
        
        debugPrint(url)
        
        let params = [
            "_id" : _id
            ] as [String : Any]
        
        checkOnlineCallServiceWithMethod(params: params as NSDictionary , url: url, postMethod : GET) { (data, error) -> () in
            return callBack(data, error)
        }
    }
    
    func getListGroup(_id:String,name:String, _ callBack: @escaping (_ data : AnyObject? , _ Message : String?)->Void) ->Void{
            
        let url: String  = DEFAULT_MAIN_DOMAIN + String(format: API_GET_LIST_GROUP)
        
        debugPrint(url)
        
        let params = [
            "_id":_id,
            "name":name
            ] as [String : Any]
        
        checkOnlineCallServiceWithMethod(params: params as NSDictionary , url: url, postMethod : POST) { (data, error) -> () in
            return callBack(data, error)
        }
    }
    
    func postKeySearch(key:String, _ callBack: @escaping (_ data : AnyObject? , _ Message : String?)->Void) ->Void{
            
        let url: String  = DEFAULT_MAIN_DOMAIN + String(format: API_POST_SEARCH)
        
        debugPrint(url)
        
        let params = [
            "key":key
            ] as [String : Any]
        
        checkOnlineCallServiceWithMethod(params: params as NSDictionary , url: url, postMethod : POST) { (data, error) -> () in
            return callBack(data, error)
        }
    }
    
    func confirmbought(_id:String, _ callBack: @escaping (_ data : AnyObject? , _ Message : String?)->Void) ->Void{
            
        let url: String  = DEFAULT_MAIN_DOMAIN + String(format: API_CONFIRM_BOUGHT)
        
        debugPrint(url)
        
        let params = [
            "_id":_id
            ] as [String : Any]
        
        checkOnlineCallServiceWithMethod(params: params as NSDictionary , url: url, postMethod : POST) { (data, error) -> () in
            return callBack(data, error)
        }
    }
    
    func getMessageGroup(room_id:String,page:Int,limit:Int, _ callBack: @escaping (_ data : AnyObject? , _ Message : String?)->Void) ->Void{
            
        let url: String  = DEFAULT_MAIN_DOMAIN + String(format: API_GET_LIST_MESSAGE,room_id,page,limit)
        
        debugPrint(url)
        
        let params = [
            :
            ] as [String : Any]
        
        checkOnlineCallServiceWithMethod(params: params as NSDictionary , url: url, postMethod : GET) { (data, error) -> () in
            return callBack(data, error)
        }
    }

    func getStickerCategory(_ callBack: @escaping (_ data : AnyObject? , _ Message : String?)->Void) ->Void{
            
        let url: String  = DEFAULT_MAIN_DOMAIN + String(format: API_GET_STICKER_CATEGORY)
        
        debugPrint(url)
        
        let params = [
            :
            ] as [String : Any]
        
        checkOnlineCallServiceWithMethod(params: params as NSDictionary , url: url, postMethod : GET) { (data, error) -> () in
            return callBack(data, error)
        }
    }
    
    
    func getStickerByCategoryId(_ callBack: @escaping (_ data : AnyObject? , _ Message : String?)->Void) ->Void{
            
        let url: String  = DEFAULT_MAIN_DOMAIN + String(format: API_GET_STICKER_OF_CATEGORYID)
        
        debugPrint(url)
        
        let params = [
            :
            ] as [String : Any]
        
        checkOnlineCallServiceWithMethod(params: params as NSDictionary , url: url, postMethod : GET) { (data, error) -> () in
            return callBack(data, error)
        }
    }
    
    func getNewFeedSearch(key:String, _ callBack: @escaping (_ data : AnyObject? , _ Message : String?)->Void) ->Void{
            
        let url: String  = DEFAULT_MAIN_DOMAIN + String(format: API_GET_FROM_SEACRH,key)
        
        debugPrint(url)
        
        let params = [
//            "key":key
            :
            ] as [String : Any]
        
        checkOnlineCallServiceWithMethod(params: params as NSDictionary , url: url, postMethod : GET) { (data, error) -> () in
            return callBack(data, error)
        }
    }
    
    func getSearchHistory(_ callBack: @escaping (_ data : AnyObject? , _ Message : String?)->Void) ->Void{
            
        let url: String  = DEFAULT_MAIN_DOMAIN + String(format: API_GET_HISTORY_SEARCH)
        
        debugPrint(url)
        
        let params = [
            :
            ] as [String : Any]
        
        checkOnlineCallServiceWithMethod(params: params as NSDictionary , url: url, postMethod : GET) { (data, error) -> () in
            return callBack(data, error)
        }
    }
    
}
