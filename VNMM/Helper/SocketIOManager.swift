//
//  SocketIOManager.swift
//  Techres-Sale
//
//  Created by kelvin on 4/19/19.
//  Copyright © 2019 vn.printstudio.res.employee. All rights reserved.
//

import UIKit
import SocketIO

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()

    let manager = SocketManager(socketURL: URL(string:DEFAULT_MAIN_DOMAIN)!, config: [.log(true), .compress])

    var  socket:SocketIOClient?

    override init() {
        super.init()
        self.socket = manager.defaultSocket
    }

    func connectToServerWithNickname(nickname: String, completionHandler: @escaping (_ userList: [[String: AnyObject]]?) -> Void) {
        socket!.emit("connectUser", nickname)

        socket!.on("userList") { ( dataArray, ack) -> Void in
            completionHandler((dataArray[0] as! [[String: AnyObject]]))
        }

        listenForOtherMessages()
    }
    private func listenForOtherMessages() {
        socket!.on("userConnectUpdate") { (dataArray, socketAck) -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userWasConnectedNotification"), object: dataArray[0] as! [String: AnyObject])
        }

        socket!.on("userExitUpdate") { (dataArray, socketAck) -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userWasDisconnectedNotification"), object: dataArray[0] as! [String: AnyObject])

        }

        socket!.on("userTypingUpdate") { (dataArray, socketAck) -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userTypingNotification"), object: dataArray[0] as? [String: AnyObject])
        }
    }

    func exitChatWithNickname(nickname: String, completionHandler: () -> Void) {
        socket!.emit("exitUser", nickname)
        completionHandler()
    }


    func sendMessage(message: String, conversationId id: String, completionHandler: @escaping (_ chatMessage: [[String: AnyObject]]?) -> Void) {

            socket!.emit("chatMessage", id, message)

    }


    func getChatMessage(completionHandler: @escaping (_ messageInfo: [String: AnyObject]) -> Void) {
        socket!.on("newChatMessage") { (dataArray, socketAck) -> Void in
            var messageDictionary = [String: AnyObject]()
            messageDictionary["nickname"] = dataArray[0] as! String as AnyObject
            messageDictionary["message"] = dataArray[1] as! String as AnyObject
            messageDictionary["date"] = dataArray[2] as! String as AnyObject

            completionHandler(messageDictionary)
        }
    }


    func sendStartTypingMessage(nickname: String) {
        socket!.emit("startTyping", nickname)
    }


    func sendStopTypingMessage(nickname: String) {
        socket!.emit("stopTyping", nickname)
    }

    func sendSeenMessage(nickname: String) {
        socket!.emit("seenMessage", nickname)
    }

    func sendLike(nickname: String) {
        socket!.emit("like", nickname)
    }

    func sendAnswer(nickname: String) {
        socket!.emit("answer", nickname)
    }

    func sendComment(nickname: String) {
        socket!.emit("comment", nickname)
    }

    func sendFollower(nickname: String) {
        socket!.emit("follower", nickname)
    }

    func sendPersonal(nickname: String) {
        socket!.emit("personal", nickname)
    }

    func establishConnection() {
        self.socket?.connect()
    }

    func closeConnection() {
        self.socket!.disconnect()
    }




}

class SocketChatIOManager: NSObject {
    static let chatSharedInstance = SocketChatIOManager()
    
    var managerChat: SocketManager?
    
    var  socketChat:SocketIOClient?
    
    override init() {
        super.init()
        
        if let url = URL(string:DEFAULT_MAIN_DOMAIN) {
            self.managerChat = SocketManager(socketURL: url, config: [.log(true), .compress, .reconnects(true)])
//            manager = SocketManager(socketURL: url,  config: [
//                .log(true),
//                .compress,
//                .reconnects(true)
////                .forcePolling(true),
////                .reconnectWait(0)
//            ])
            self.socketChat = managerChat?.defaultSocket
            
        }
      
    }
    
    
    func establishConnection() {
        self.socketChat?.connect()
        
        dLog(self.managerChat?.status as Any)
        
        socketChat?.on("connect") {data, ack in
            dLog(data.description)
        }
        
    }
    

    func closeConnection() {
        self.socketChat!.disconnect()
    }
}

class SocketGameIOManager: NSObject {
    static let sharedInstance = SocketGameIOManager()

    
    let manager = SocketManager(socketURL: URL(string:"")!, config: [.log(true), .compress])
    var socket: SocketIOClient?
    
    override init() {
        super.init()
    }
    
    func initSocketInstance(_ domain: String, _ namespace: String, _ isConnect: Bool = false) {
        self.socket = manager.socket(forNamespace: namespace)
        if isConnect {
            self.socket?.connect()
        }
    }
    
    func establishConnection() {
    }
    

    func closeConnection() {
        self.socket?.disconnect()
    }
}

class SocketIOBill: NSObject {
    static let billSharedInstance = SocketIOBill()
    
    
    let manager = SocketManager(socketURL: URL(string:"")!, config: [.log(true), .compress])
//    let manager = SocketManager(socketURL: URL(string:ManageCacheObject.getGeneralConfig().realtime_domain)!, config: [.log(true), .compress])


    var  socket_bill:SocketIOClient?

    override init() {
        super.init()
        self.socket_bill = manager.socket(forNamespace: "/customers")

    }

    func establishConnection() {
        self.socket_bill?.connect()
    }


    func closeConnection() {
        self.socket_bill!.disconnect()
    }
}

