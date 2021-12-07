//
//  ChatMessageViewController.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 04/25/21.
//

import UIKit
import ObjectMapper

class ChatMessageViewController: UIViewController {

    
    @IBOutlet weak var tbl_listGroup: UITableView!
    
    var listGroupp = [ListGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getListGroup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getListGroup()
    }
    
    
    func getListGroup(){
        ResAPI.sharedInstance.getListGroup(_id: ManageCacheObject.getCurrentAccount()._id, name: ManageCacheObject.getCurrentAccount().first_name + ManageCacheObject.getCurrentAccount().last_name,{ (data, Message) -> Void in
                if(data != nil) {
                    let response:ResResponse = data as! ResResponse
                    if response.code == 200 {
                        if let DataResponse  = Mapper<ListGroup>().mapArray(JSONObject: response.data) {
                            self.listGroupp = DataResponse
                            self.tbl_listGroup.reloadData()
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

extension ChatMessageViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGroupp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listGroupTableViewCell", for: indexPath) as! listGroupTableViewCell
        
        cell.lbl_name_user.text = listGroupp[indexPath.row].room_name
        cell.lbl_last_message.text = "Đã gửi cho bạn một tin nhắn"
        cell.img_avatar_user.kf.setImage(with: URL(string: listGroupp[indexPath.row].room_avatar))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : ChatTwoUserViewController?
        vc = UIStoryboard.chatTwoUserViewController()
        vc!.OtherMemberId = listGroupp[indexPath.row].user_second_id
        vc!.OtherMemberName = listGroupp[indexPath.row].room_name
        vc!.avatar = listGroupp[indexPath.row].room_avatar
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

class listGroupTableViewCell : UITableViewCell {
    
    @IBOutlet weak var lbl_name_user: UILabel!
    
    @IBOutlet weak var img_avatar_user: UIImageView!
    @IBOutlet weak var lbl_last_message: UILabel!
}
