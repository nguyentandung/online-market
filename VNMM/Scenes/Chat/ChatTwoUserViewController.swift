//
//  ChatTwoUserViewController.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 05/05/21.
//

import UIKit
import Alamofire
import ObjectMapper
import SKPhotoBrowser
import Kingfisher
import DKImagePickerController
import DropDown
import Loaf
import YPImagePicker
import AVKit
import VIMediaCache
import Photos
import GSPlayer

protocol ChooseStickerDelegate {
    
    func tapSticker(pos:Int)
}


class ChatTwoUserViewController: UIViewController, NavigationControllerCustomDelegate {

    @IBOutlet weak var tbl_chat: UITableView!
    @IBOutlet weak var tf_chatInput: UITextField!
    
    @IBOutlet weak var btn_sticker: UIButton!
    @IBOutlet weak var btn_image_gallery: UIButton!
    @IBOutlet weak var bottom_view_comment: NSLayoutConstraint!
    
    @IBOutlet weak var width_image_button: NSLayoutConstraint!
    @IBOutlet weak var width_sticker_icon: NSLayoutConstraint!
    @IBOutlet weak var btn_send: UIButton!
    
    @IBOutlet weak var view_sticker: UIView!
    
    @IBOutlet weak var img_avatar_user: UIImageView!
    @IBOutlet weak var height_col_stickerCategory: NSLayoutConstraint!
    @IBOutlet weak var height_view_sticker: NSLayoutConstraint!
    @IBOutlet weak var col_sticker_category: UICollectionView!
    
    @IBOutlet weak var col_sticker: UICollectionView!
    
    @IBOutlet weak var lbl_other_user: UILabel!
    
    @IBOutlet weak var view_top_chat: UIView!
    
    
    
    @IBOutlet weak var view_bottom_chat: UIView!
    var OtherMemberId = ""
    var OtherMemberName = ""
    
    var groupChatId = ""
    
    var avatar = ""
    
    var messageList = [Message]()
    var stickerCategory = [Sticker]()
    var stickerById = [Sticker]()
    
    var image_selecteds = [UIImage]()
    var image_urls = [String]()
    var imageUploadCount = 0
    var scrollToBottomWhenReceiveMessage = true
    var page = 1
    var limit = 50
    var total_record = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lbl_other_user.text = self.OtherMemberName
        tf_chatInput.delegate = self
        
        tf_chatInput.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                                  for: .editingChanged)
        tbl_chat.allowsSelection = false
        setupReceiveMessage()
        setupNotificationCenter()
        createGroupPersonal()
        
        self.view_sticker.isHidden = true
        self.height_view_sticker.constant = 0
        self.bottom_view_comment.constant = 0
        self.height_col_stickerCategory.constant = 0
//        self.hideKeyboardWhenTappedAround()
//        self.hideKeyboardWhenTappedAround(viewTouchDismiss: btn_send)
        getStickerCategory()
        getStickerCategoryById()
        customLayout()
        
        self.tbl_chat.backgroundView = UIImageView(image: UIImage(named: "bg_message"))
        
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton:true, addButton:true, title:"")
        navigationItem.hidesBackButton = true

        navigationControllerCustom.navigationBar.barTintColor = UIColor.clear
        
        self.img_avatar_user.kf.setImage(with: URL(string: self.avatar))

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
       if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
           
           bottom_view_comment.constant = keyboardSize.height + 0
        
        self.view_sticker.isHidden = true
        self.height_view_sticker.constant = 0

           
           UIView.animate(withDuration: 0.5, animations: {
               self.view.layoutIfNeeded()
               
           }, completion: {_ in
               
           })
        
        if !self.messageList.isEmpty {
            self.tbl_chat.scrollToRow(at: IndexPath(row: self.messageList.count - 1, section: 0), at: .bottom, animated: true)
        }

       }
       

   }
   
   @objc func keyboardWillHide(_ notification: NSNotification) {
       
       bottom_view_comment.constant = 5
    
       UIView.animate(withDuration: 0.5, animations: {
           self.view.layoutIfNeeded()
          
       }, completion: {_ in
           
       })
   }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        
        self.view_sticker.isHidden = true
        self.height_view_sticker.constant = 0

        
        if(textField.text!.isEmpty){
            UIView.transition(with: btn_sticker, duration: 1,
                              options: .transitionFlipFromBottom,
                    animations: {
                    self.btn_sticker.isHidden = false
            })
            
            UIView.transition(with: btn_image_gallery, duration: 1,
                              options: .transitionFlipFromBottom,
                    animations: {
                    self.btn_image_gallery.isHidden = false
            })

            self.width_image_button.constant = 30
            self.width_sticker_icon.constant = 26
        }else{
//            self.btn_sticker.isHidden = true
//            self.btn_image_gallery.isHidden = true
//            self.width_image_button.constant = 0
//            self.width_sticker_icon.constant = 0
        }
        
    }
    
    func customLayout() {
        
         self.view_top_chat.layer.shadowOpacity = 1
         self.view_top_chat.layer.masksToBounds = false
         self.view_top_chat.layer.shadowRadius = 2
         self.view_top_chat.layer.shadowColor = UIColor.lightGray.cgColor
         self.view_top_chat.layer.shadowOffset = .zero
        
        self.view_bottom_chat.layer.shadowOpacity = 1
        self.view_bottom_chat.layer.masksToBounds = false
        self.view_bottom_chat.layer.shadowRadius = 2
        self.view_bottom_chat.layer.shadowColor = UIColor.lightGray.cgColor
        self.view_bottom_chat.layer.shadowOffset = .zero
   
    }
    
    
    @IBAction func Action_openGallery(_ sender: Any) {
        
        self.height_view_sticker.constant = 0
        self.bottom_view_comment.constant = 0
        
        self.image_urls = []
        self.image_selecteds = []
//        self.imageFileUpload = [:]
        
        var config = YPImagePickerConfiguration()
        config.screens = [.library]
        config.library.options = .none
        config.library.onlySquare = false
        config.library.isSquareByDefault = false
        config.library.minWidthForItem = nil
        config.library.mediaType = YPlibraryMediaType.photoAndVideo
        config.library.defaultMultipleSelection = true
        config.library.maxNumberOfItems = 10
        config.library.minNumberOfItems = 1
        config.library.numberOfItemsInRow = 4
        config.library.spacingBetweenItems = 1.0
        config.library.skipSelectionsGallery = true
        config.library.preselectedItems = nil
        config.showsPhotoFilters = false
        config.showsVideoTrimmer = false
        config.startOnScreen = YPPickerScreen.library
       
        config.video.fileType = .mp4
        config.video.recordingTimeLimit = 10 * 60.0
        config.video.libraryTimeLimit = 10 * 60.0
        config.video.minimumTimeLimit = 3.0
        config.video.trimmerMaxDuration = 10 * 60.0
        config.video.trimmerMinDuration = 3.0
        config.showsPhotoFilters = false
        config.showsVideoTrimmer = false
        config.startOnScreen = YPPickerScreen.library
        
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            
            var videos_selected = [YPMediaVideo]()
            
            for item in items {
                switch item {
                case .photo(let photo):
                    let image = photo.originalImage.fixedOrientation()!.resizeImage(500, opaque: true)
                    self.image_selecteds.append(image)
                case .video(let video):
                    videos_selected.append(video)
                }
            }
            
            if videos_selected.count > 1 {
                picker.dismiss(animated: true, completion: nil)
                Loaf("Vui lòng chỉ chọn 1 video", state: .error, presentingDirection: .left, dismissingDirection: .vertical, sender: self).show(.custom(2.5), completionHandler: nil)
                self.image_selecteds.removeAll()
                videos_selected.removeAll()
            }
            else {
                if(self.image_selecteds.count > 0){
                    for i in 0..<self.image_selecteds.count {
                        let item = self.image_selecteds[i]
                        let parameters = [String:AnyObject]()
                        let imageData: Data = item.jpegData(compressionQuality: 0.5)!
                        let date = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
                        let result = formatter.string(from: date)
                        let randomString = String((0..<15).map{ _ in result.randomElement()! })
                        let file_name = String(format: "%@.%@", randomString, "jpg")
                        
                        
//                        self.sendNameFileChat(fileName: file_name, size: Utils.getImageSize(image: item), completion: { file in
//                            print("\(file)")
//                            self.image_urls.append(file)
//                            if self.image_urls.count == self.image_selecteds.count {
//                                self.sendImageMessage(images:self.image_urls)
//                            }
//                        })
                        self.uploadPhotoToServer(parameters: parameters, filename: file_name, imageData: imageData)
                    }
                    
                }
                
                
//                if (videos_selected.count > 0) {
//                    for video in videos_selected {
//                        if let thumb = Helper.generateThumbnail(path: video.url) {
//                            self.thumbVideo = thumb
//                        }
//
//                        let parameters = [String:AnyObject]()
//                        //time processing
//                        let date = Date()
//                        let formatter = DateFormatter()
//                        formatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
//                        let result = formatter.string(from: date)
//                        //file name base on time select
//                        let randomString = String((0..<15).map{ _ in result.randomElement()! })
//                        let file_name = String(format: "file_name_%@.%@", randomString, "mp4")
//
//                        self.sendNameFileChat(nameFile: file_name, size: Utils.getFileSize(url: video.url), completion: { file in
//                            self.sendVideoMessage(video_name: file_name, video_url: file.linkOriginal)
//                            self.uploadVideoToServer(parameters: parameters, filename: file_name, videoUrl: video.url)
//                        })
//
//                    }
//                }
                
                picker.dismiss(animated: true, completion: nil)
            }
        }
        self.present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func btn_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func Action_sendMessage(_ sender: Any) {
        if tf_chatInput.text != "" {
            let msg = MessageEmit()
            msg.room = self.groupChatId
            msg.message = self.tf_chatInput.text!
            msg.user_first_id = ManageCacheObject.getCurrentAccount()._id
            msg.user_second_id = self.OtherMemberId
            msg.images = [""]
            SocketChatIOManager.chatSharedInstance.socketChat!.emit(KEY_CHATTEXT, msg.toJSON())
            
            dLog("Okee")
            self.tf_chatInput.text = ""
        }
       
    }
    
    
    @IBAction func Action_chooseSticker(_ sender: Any) {
        
        self.bottom_view_comment.constant = 300
        self.height_col_stickerCategory.constant = 50
        
        UIView.transition(with: view_sticker, duration: 0.5,
                          options: .transitionFlipFromBottom,
                animations: {
                self.view_sticker.isHidden = false
                    self.height_view_sticker.constant = 300
        })
        
    }
    
//    func receiveMessage() {
//        SocketChatIOManager.chatSharedInstance.socketChat!.on(KEY_RES_CHAT_TEXT) { data, ack in
//            if let messageRes: MessageRes = Mapper<MessageRes>().map(JSONObject: data[0]) {
//                self.addMessage(messageRes)
//            }
//        }
//    }
    
    
    func createGroupPersonal() {
        ResAPI.sharedInstance.createGroupChat(user_first_id: ManageCacheObject.getCurrentAccount()._id, user_second_id: self.OtherMemberId,user_first_name:ManageCacheObject.getCurrentAccount().first_name + ManageCacheObject.getCurrentAccount().last_name,user_second_name:self.OtherMemberName, callBack: { [self] (data, mes) -> Void in
             if(data != nil){
                 let response:ResResponse = data as! ResResponse
                 if(response.code==200){
                    let chatGroup = Mapper<GroupTwoUser>().map(JSONObject: response.data) ?? GroupTwoUser()
                    self.groupChatId = chatGroup._id
                    self.joinRoom()
                    self.getChatMessage()
                    
                }
             }else{
                 let alert = UIAlertController(title: "", message: LOAD_FAIL, preferredStyle:.alert)
                 alert.addAction(UIAlertAction(title: "", style: .default, handler: nil))
                 self.present(alert, animated: true, completion: nil)
             }
             JHProgressHUD.sharedHUD.hide()
         })
    }
    
    func getChatMessage(){
        
        ResAPI.sharedInstance.getMessageGroup(room_id: self.groupChatId,page:self.page,limit:self.limit,{(data, Message) -> Void in
                if(data != nil) {
                    let response:ResResponse = data as! ResResponse
                    if response.code == 200 {
                        if let DataResponse  = Mapper<MessageResponse>().map(JSONObject: response.data) {
                            self.messageList = DataResponse.list
                            self.tbl_chat.reloadData()
                            if(!self.messageList.isEmpty) {
                                
                                self.tbl_chat.scrollToRow(at: IndexPath(row: self.messageList.count - 1, section: 0), at: .bottom, animated: true)
//                                self.tbl_chat.updateRow(row: self.messageList.count - 1)
                               
                            }
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
    
    func getStickerCategory(){
        
        ResAPI.sharedInstance.getStickerCategory({(data, Message) -> Void in
                if(data != nil) {
                    let response:ResResponse = data as! ResResponse
                    if response.code == 200 {
                        if let DataResponse  = Mapper<Sticker>().mapArray(JSONObject: response.data) {
                            self.stickerCategory = DataResponse
                            self.col_sticker_category.reloadData()
                            self.col_sticker.reloadData()
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
    
    func getStickerCategoryById(){
        
        ResAPI.sharedInstance.getStickerByCategoryId({(data, Message) -> Void in
                if(data != nil) {
                    let response:ResResponse = data as! ResResponse
                    if response.code == 200 {
                        if let DataResponse  = Mapper<Sticker>().mapArray(JSONObject: response.data) {
                            self.stickerById = DataResponse
                            self.col_sticker_category.reloadData()
                            self.col_sticker.reloadData()
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

    
    func joinRoom() {
        let connection = ConnectRoom()
        connection.userFirstId = ManageCacheObject.getCurrentAccount()._id
//        connection.userSecondId = self.OtherMemberId
//        connection.room = self.groupChatId
        SocketChatIOManager.chatSharedInstance.socketChat!.emit(KEY_JOINROOM, ManageCacheObject.getCurrentAccount()._id)
    }
    
    func setupReceiveMessage(){
       
        
        SocketChatIOManager.chatSharedInstance.socketChat!.on(KEY_RES_CHAT_TEXT) { data, ack in
            if let messageRes: MessageRes = Mapper<MessageRes>().map(JSONObject: data[0]) {
                self.addMessage(messageRes)
            }
        }
        
        SocketChatIOManager.chatSharedInstance.socketChat!.on(KEY_RES_CHAT_IMAGE) { data, ack in
            if let messageRes = Mapper<MessageRes>().map(JSONObject: data[0]) {
                self.addMessage(messageRes)
            }
        }
    }
    
    func addMessage(_ messageRes: MessageRes) {

        let message = Message()
        message.message = messageRes.message
        message.images = messageRes.images
        message.room = messageRes.room
        message.user_first_id = messageRes.user_first_id
        message.user_second_id = messageRes.user_second_id
//        self.messageList.insert(message, at: 0)
        self.messageList.append(message)
        self.tbl_chat.performBatchUpdates({

            self.tbl_chat.insertRows(at: [IndexPath(row: self.messageList.count - 1,
                                                     section: 0)],
                                      with: .automatic)
        }, completion: nil)
        
        if messageRes.user_first_id == ManageCacheObject.getCurrentAccount()._id {

            if(!messageList.isEmpty) {
               
                self.tbl_chat.scrollToRow(at: IndexPath(row: self.messageList.count - 1, section: 0), at: .bottom, animated: true)
               
            }
        } else {

        }
    
        self.tbl_chat.reloadData()
    }

    func showBtnNewMessage() {
       
    }

    func hideBtnNewMessage() {
        
    }
    
    
    func sendImageMessage(images:[String]) {
        
        let msg = MessageEmit()
        msg.room = self.groupChatId
        msg.message = ""
        msg.user_first_id = ManageCacheObject.getCurrentAccount()._id
        msg.user_second_id = self.OtherMemberId
         
        for item in images {
            self.image_urls.append(item)
        }
        msg.images = self.image_urls
        SocketChatIOManager.chatSharedInstance.socketChat!.emit(KEY_CHATIMAGE, msg.toJSON())
        self.image_selecteds.removeAll()
        self.image_urls.removeAll()
        self.tbl_chat.reloadData()
    }
    
    func sendStickerMessage(images:String) {
        
        let msg = MessageEmit()
        msg.room = self.groupChatId
        msg.message = ""
        msg.user_first_id = ManageCacheObject.getCurrentAccount()._id
        msg.user_second_id = self.OtherMemberId
         
        msg.images.append(images)
        SocketChatIOManager.chatSharedInstance.socketChat!.emit(KEY_CHATIMAGE, msg.toJSON())
        
        self.tbl_chat.reloadData()
    }
    
    func sendNameFileChat(fileName: String) {
        
        ResAPI.sharedInstance.getLinkImage(file_name: fileName, ({ (data, Message) -> Void in
            if(data != nil) {
                let response:ResResponse = data as! ResResponse
                if response.code == 200 {
                    let linkurl = DEFAULT_MAIN_DOMAIN + "/" + (response.data as! String)
                    self.image_urls.append(linkurl)
                    self.imageUploadCount += 1
                    if self.imageUploadCount == self.image_selecteds.count{
                        self.sendImageMessage(images: self.image_urls) ///con dung, comment de test
                       
                    }

                }
                else {
                    let alert = UIAlertController(title:LOAD_FAIL , message: response.message, preferredStyle:.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                JHProgressHUD.sharedHUD.hide()
            }
            else {
                Toast.show(message: "Thử lại", controller: self)
            }
            JHProgressHUD.sharedHUD.hide()
        }))
    }
    
    func uploadPhotoToServer( parameters: Dictionary<String, AnyObject>, filename:String, imageData: Data?) {
        
        var url = ""
        url = DEFAULT_MAIN_DOMAIN + String(format: API_UPLOAD_LINKIMAGE)

        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data",
            "Authorization":"\(ManageCacheObject.getCurrentAccount().accessToken)"
        ]
        
        let successHandler: ((DataResponse<Any>) -> Void)? = {res in
            

//            debugPrint("Upload thanh cong")
            self.sendNameFileChat(fileName: filename)
            dLog("upload success " + res.description)
            

        }
        
        let errorHandler: ((Error) -> Void)? = {err in
            print("\(err)")
        }
        
        let progressHandler: ((Double) -> Void)? = {err in
            
        }
        
        VideoUploadClient.uploadWithData(serverUrl: URL(string: url)!, headers: headers, fileData: imageData!, filename: filename, withName: "send_file", progressing: progressHandler, success: successHandler, failure: errorHandler)
    }
    

}

extension ChatTwoUserViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if messageList[indexPath.row].user_first_id == ManageCacheObject.getCurrentAccount()._id {
            
            if messageList[indexPath.row].message != "" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageTextTableViewCell", for: indexPath) as! MyMessageTextTableViewCell
                cell.lbl_content_message.text = messageList[indexPath.row].message
                
                
                
                
                cell.view_my_message.layer.cornerRadius = cell.view_my_message.bounds.height/2
                
                cell.view_my_message.backgroundColor = ColorUtils.hexStringToUIColor(hex: "#0277BD")
                
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageImageTableViewCell", for: indexPath) as! MyMessageImageTableViewCell
                
                cell.img_image1.kf.setImage(with: URL(string: messageList[indexPath.row].images[0]))
                if messageList[indexPath.row].images[0].contains(".mp4")
                {
                    
                }else if messageList[indexPath.row].images[0].contains("giphy"){
                    
                    cell.widthImage.constant = 200
                    cell.heightImgage.constant = 150
                }else{
                    cell.widthImage.constant = 200
                    cell.heightImgage.constant = 180
                    
                }
                
                
                return cell
            }
           
        }else {
            
            
            if messageList[indexPath.row].message != "" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OtherMessageTextTableViewCell", for: indexPath) as! OtherMessageTextTableViewCell
                
                cell.lbl_content_message.text = messageList[indexPath.row].message
                
                cell.img_avatar.kf.setImage(with: URL(string: self.avatar))
                
                cell.view_other_message.layer.cornerRadius = cell.view_other_message.bounds.height/2
                
                cell.view_other_message.backgroundColor = ColorUtils.hexStringToUIColor(hex: "#546E7A")
                
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OtherMessageImageTableViewCell", for: indexPath) as! OtherMessageImageTableViewCell
                
                cell.img_avatar.kf.setImage(with: URL(string: self.avatar))
                cell.img_image1.kf.setImage(with: URL(string: messageList[indexPath.row].images[0]))
                return cell
            }
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if messageList[indexPath.row].message != "" {
            return UITableView.automaticDimension
        }else{
            return 200
        }
    }
    
}

extension ChatTwoUserViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.height_view_sticker.constant = 0
        self.bottom_view_comment.constant = 0
        self.height_col_stickerCategory.constant = 0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.height_view_sticker.constant = 0
        self.bottom_view_comment.constant = 0
        self.height_col_stickerCategory.constant = 0
    }
}

extension ChatTwoUserViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return stickerCategory.count
        default:
            return stickerById.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StickerCategoryCollectionViewCell", for: indexPath) as! StickerCategoryCollectionViewCell
            cell.sticker.kf.setImage(with: URL(string: stickerCategory[indexPath.row].link_original))
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StickerListCollectionViewCell", for: indexPath) as! StickerListCollectionViewCell
            cell.sticker.kf.setImage(with: URL(string: stickerById[indexPath.row].link_original))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 1:
            return CGSize(width: 45, height: 45)
        default:
            return CGSize(width:(col_sticker.bounds.width - 8 ) / 4, height: (col_sticker.bounds.width - 8 ) / 4)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView.tag {
        case 1:
            return 5
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView.tag {
        case 1:
            return 8
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 1:
            break
        default:
            sendStickerMessage(images: stickerById[indexPath.row].link_original)
    }
}
}

extension ChatTwoUserViewController : ChooseStickerDelegate {
    func tapSticker(pos: Int) {
        
    }
}

class StickerCategoryCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var sticker: UIImageView!
}

class StickerListCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var sticker: UIImageView!
    
    var delegate : ChooseStickerDelegate?
    
}
