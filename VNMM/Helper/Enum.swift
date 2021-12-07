//
//  Enum.swift
//  VNMarket
//
//  Created by Nguyen Tan Dung on 04/12/21.
//

import Foundation
import UIKit

enum UPLOAD_FILE_TYPE:Int {
    case TWO_PERSONAL = 4
    case GROUP = 3
}



enum SALARY_STATUS: Int {
    case ALLOW = 1
    case DENINED = 0
}
enum APPLY_POINT_PAYMENT_STATUS: Int {
    case ALLOW = 1
    case DENINED = 0
}
enum LOCK_SCREEN: String {
    case LOCKED = "LOCKED"
}

enum DISCOUNT_TYPE: Int {
    case DISCOUNT_ALL = 1
    case DISCOUNT_FOOD = 2
    case DISCOUNT_DRINK = 3
}

enum CATEGORY_FOOD_TYPE: Int {
    case FOOD = 1
    case DRINK = 2
    case OTHER = 3
    case SEA_FOOD = 4
    
}
enum STATUS_REQUEST: Int{
    case STATUS_SUCCESS = 200
    case STATUS_AUTH = 410
}

enum STATUS_LEAVE: Int{
    case PENDING = 0
    case CANCELLED = 1
    case COMPLETED = 2
}
enum CONSTANT_KEY:String{
    case PROJECT_ID = "net.aloline.vn"
    case NODE_PROJECT_ID = "project.customer.key"
}
enum UPLOAD_IMAGE_TYPE: Int{
    case EMPLOYEE = 1
    case NEWS = 2
    case TASK = 3
    case CHAT = 6
}
enum TASK_STATUS: Int{
    case PENDING = 0
    case PROCESS = 1
    case COMPLETED = 2
}



enum EMPLOYEE_STATUS:Int {
    case AVAILABLE = 1
    case DISABLE = 0
}

enum MIGRATION_STATUS:Int {
    case DONE = 1
    case PENDING = 0
}

//UPDATE(1), FIX_BUG(2), ADD_FUNCTION(3)
enum FEEDBACK_STATUS: Int {
    case UPDATE = 1
    case FIX_BUG = 2
    case ADD_FUNCTION = 3
}

enum MESSAGE_TYPES: String {
    case TEXT = "text"
    case AUDIO = "audio"
    case IMAGE = "image"
    case VIDEO = "video"
    case FILE = "file"
    case STICKER = "sticker"
    case CHANGE_BACKGROUND = "update_background"
}

enum CONVERSATION_TYPE_GROUP_CHAT: String {
    case GROUP = "group"
    case TWOPERSONAL = "TWO_PERSIONAL"
}

enum FILE_TYPE_CHAT: String {
    case WORK = "work"
    case PERSONAL = "personal"
    case GROUP = "group"
}

enum Direction : String {
    
    case north, east, south, west,wests,westss,westsss
    
    static var allValues = [Direction.north, .east, .south, .west, .wests, .westss, .westsss]
    
}

enum UPLOAD_PHOTO_TYPE: Int {
    case USER_AVATAR = 1
    case NEWSFEED = 2
    case REVIEW = 3
    case COVER = 4
    case BANNER_ADS = 5
    case VIEW_NEWSFEED_REVIEW = 6
    case HOW_MANY_MINUTE = 7
}


enum POST_TYPE : Int {
    case LAPTOP = 0
    case PHONE = 1
    case CAR = 2
    case MOTOCYCLE = 3
    case BYCYCLE = 4
    case HOUSE = 5
    case FURITURE = 6
}

