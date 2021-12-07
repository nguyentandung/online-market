//
//  Configs.swift
//  Techres-Supplier (iOS)
//
//  Created by KELVIN on 10/03/2021.
//

import Foundation
import UIKit

var DEFAULT_MAIN_DOMAIN = "http://173.254.232.92:4000"

//var DEFAULT_MAIN_DOMAIN = "http://172.16.4.206:4000"

// Replace the red string below with the name you'll give to your own version of this app
var SECRET_KEY_NODE = "cHJvamVjdC5jdXN0b21lci5rZXkmYWJjJF4mJQ=="
var RESTAURANT_ID = 0
var KEY_PUSH_TOKEN = "key_push_token"
var KEY_ACCOUNT = "key_account"
var KEY_TOKEN = "key_token"
var KEY_PHONE = "key_phone"
var KEY_CONFIG = "key_config"
var KEY_SETTING = "key_setting"
var KEY_MEMBERCARD = "KEY_MEMBERCARD"
var KEY_TAKE_AWAY_CART = "key_take_away_cart"
var KEY_GAME_ACCOUNT = "key_game_account"

var KEY_HISTORY = "search_history"

let KEY_FIRST_RUN = "KEY_FIRST_RUN"

let KEY_FIRT_RUN = "KEY_FIRT_RUN"
let KEY_BRANCH_ID = "KEY_BRANCH_ID"
var API_PORT = 8080
var LOAD_FAIL = "Thông báo"
var SERVER_ERROR = "Có lỗi xảy ra khi kết nối tới máy chủ, vui lòng thử lại."
var PLEASE_TRY_AGAIN = "Vui Lòng Thử Lại"
var ALERT = "Thông báo"
var SUSCESS = "Thành công"

var ENABLE = 1
var DISABLE = 0


// ============== API_URL_KEY ============
var  API_CONFIG = "/api/configs"
var  API_REGISTRY_DEVICE = "/api/register-supplier-device"
var  API_CHECK_VERSION = "/api/check-version"



//var LOAD_FAIL = "Lỗi kết nối mạng!"
//var PLEASE_TRY_AGAIN = "Thử lại"
//var KEY_UD_USER = "User"
//var KEY_UD_CONFIG = "Config"
//var KEY_DEVICE_ID = "Device_id"
//var AGREE  = "Đồng ý"
//var CANCEL  = "Huỷ"
//var ACCOUNT = "TÀI KHOẢN"
//
//var TAB_NEWS = 0
//var TAB_TASK = 1
//var TAB_GROUP_CHAT = 2
//var TAB_CONTACT = 3
//var TAB_ACCOUNT = 4

//reaction type
//var LOVE = "love"
//var SMILE = "smile"
//var LIKE = "like"
//var ANGRY = "angry"
//var SAD = "sad"
//var WOW = "wow"


// ====== STATUS ORDER ========
//var ORDER_STATUS_COMPLETED = 2
var STATUS_CODE_SUCCESS = 200


var  UNREACHABLE_NETWORK = "UNREACHABLE_NETWORK"
var  REACHABLE_NETWORK = "REACHABLE_NETWORK"


//MARK:url POST
var API_LOGIN = "/auth/login"
var API_REGISTER = "/auth/register"
var API_POST = "/post/create"
var API_UPLOAD_LINKIMAGE = "/post/upload-image"
var API_CREATE_GROUPCHAT = "/user/get-room"
var API_UPDATE_AVATAR = "/user/update-avatar"
var API_POST_SEARCH = "/user/post-key"
var API_CONFIRM_BOUGHT = "/post/confirm-bought"

//MARK: url GET
var API_GET_NEWFEED = "/post/get-all?prioritize_type=%d"
var API_GET_LINK = "/post/get-image"
var API_GET_INFORMATION = "/user/information"
var API_GET_MY_POST = "/user/all-post"
var API_GET_LIST_GROUP = "/user/get-list-room"
var API_GET_LIST_MESSAGE = "/user/get-list-messages?room_id=%@&page=%d&limit=%d"
var API_GET_STICKER_CATEGORY = "/stickers/category"
var API_GET_STICKER_OF_CATEGORYID = "/stickers/16"
var API_GET_FROM_SEACRH = "/post/search-post?key=%@"
var API_GET_HISTORY_SEARCH = "/user/get-key"

