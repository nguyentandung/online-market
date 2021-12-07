//
//  ColorUtils.swift
//  VNMarket
//
//  Created by Nguyen Tan Dung on 04/07/21.
//

import Foundation
import UIKit
class ColorUtils{
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    static func toolbar()->UIColor{
        return hexStringToUIColor(hex: "#FFA233")
    }
    static func green()->UIColor{
        return hexStringToUIColor(hex: "#34A853")
    }
    static func green_online()->UIColor{
        return hexStringToUIColor(hex: "#02bf54")
    }
    static func white()->UIColor{
        return UIColor.white
    }
    static func black()->UIColor{
        return UIColor.black
    }
    static func grey()->UIColor{
        return hexStringToUIColor(hex: "#D0D0D0")
    }
    static func yellow()->UIColor{
        return hexStringToUIColor(hex: "#f7bc0e")
    }
    static func blue()->UIColor{
        return hexStringToUIColor(hex: "#418bca")
    }
    static func main_color()->UIColor{
        return hexStringToUIColor(hex: "#FFA233")
    }
    
    static func red_color()->UIColor{
        return hexStringToUIColor(hex: "#EA4335")
    }
    static func blue_color()->UIColor{
        return hexStringToUIColor(hex: "#418bca")
    }
  
  
    static func blackTransparent()->UIColor{
        
       let black = hexStringToUIColor(hex: "#000000")
        let blackOpacity = black.withAlphaComponent(0.7)
        return blackOpacity;
    }
    
    static func pending_color()->UIColor{
        return hexStringToUIColor(hex: "#418bca")
    }
    
    static func waiting_payment_color()->UIColor{
        return hexStringToUIColor(hex: "#FFA233")
    }
    
    static func waiting_completed_color()->UIColor{
        return hexStringToUIColor(hex: "#EA4335")
    }
    
    static func order_detail_pending()->UIColor{
        return hexStringToUIColor(hex: "#FFA233")
    }

    static func order_detail_waiting_completed_color()->UIColor{
        return hexStringToUIColor(hex: "#4285F4")
    }
    
    static func order_detail_done_color()->UIColor{
        return hexStringToUIColor(hex: "#34A853")
    }
    
    static func order_detail_canceled()->UIColor{
        return hexStringToUIColor(hex: "#EA4335")
    }
    
    static func groupChatMyMessageColor()->UIColor{
        return hexStringToUIColor(hex: "#d5f1ff")
    }
    
  
    static func likeColor()->UIColor{
        return hexStringToUIColor(hex: "#2f74b5")
    }
    
    static func loveColor()->UIColor{
        return hexStringToUIColor(hex: "#ee7470")
    }
    
    static func emojiColor()->UIColor{
        return hexStringToUIColor(hex: "#f2cc66")
    }
    
    static func buttonLoginColor() -> UIColor {
        return hexStringToUIColor(hex: "#03DAC5")
    }
    
    static func backgroundAppColor() -> UIColor {
        return hexStringToUIColor(hex: "#03DAC5")
    }
     
    static func lowOrangeColor() ->UIColor {
        return hexStringToUIColor(hex: "#FFB74D")
    }
}

