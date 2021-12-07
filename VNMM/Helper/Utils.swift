//
//  Utils.swift
//  GS_iOS
//
//  Created by kelvin on 11/8/18.
//  Copyright © 2018 vn.eteacher. All rights reserved.
//

import UIKit
import Foundation

class Utils: NSObject {
    static func getUDID()-> String{
        let UDID = UIDevice.current.identifierForVendor!.uuidString
        
        return UDID.lowercased()
}
    
    static func encoded(str:String)->String{
        
        if let base64Str = str.base64Encoded() {
            print("Base64 encoded string: \"\(base64Str)\"")
            return base64Str
        }
        return str
    }
    
    
    static func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        
        
        
        return label.frame.height + 20
    }
    
    
    
    static func formatMoney(money : Int) -> Double{
        let price = Double(money)/1000
        
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
        return price
    }
    
    static func listToString(arr : [String])-> String
    {
        var str = ""
        for index in 0..<arr.count
        {
           if(index == 0)
            {
                 str = arr[index]
            }
            else
            {
                 str = str + " , " + arr[index]
            }
        }
        return str
    }
    
    static func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    static func dateToString(date : Date)-> String
    {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "dd/MM/yyyy"
        
        let string = formatter.string(from: date)
        return string
    }
    static func doubleToPrecent(value : Double)-> String
    {
        let index = value*100
        let str = String(format: "%.2f%%", index)
        return str
    }
    
    static func getReadablePrice(amount:Float)->String{
        var suffix:String = ""
        var digits:Int?
        //debugPrintln(amount)
        var reducedAmount:Float?
        
        reducedAmount = amount / 1000;
        suffix = "K";
        digits = 1;
        
        let f1 = (amount - floorf(amount))
        let f2 = powf(0.1, Float(digits!))-Float(0.0001)
        
        if (f1 < f2) {
            digits = 0
        }
        
        let number = NumberFormatter()
        number.usesGroupingSeparator = true
        number.maximumFractionDigits = 2
        number.minimumFractionDigits = digits!
        let strAmount = number.string(from: NSNumber(value: reducedAmount!))
        return String(format: "%@%@",strAmount!,suffix)
        
    }
    
    
    static func getFileSize(url:URL) -> Int {
        do {
            //return [FileAttributeKey : Any]
            let resources = try url.resourceValues(forKeys:[.fileSizeKey])
            let fileSize = resources.fileSize!
            
            return Int(fileSize/1024)
        } catch {
            return 0
        }
    }
    
    static func getImageSize(image:UIImage) -> Int {

        guard let data = image.pngData() else {
           return 0
       }

       var size: Double = 0.0
       size = Double(data.count)

       return Int(size / 1024)
    }

   
    static func stringVietnameseMoneyFormatWithNumber(amount:Float, unit_name :String = "")->(String){
        let number = NumberFormatter()
        number.usesGroupingSeparator = true
        number.groupingSeparator = "."
        number.groupingSize = 3
        
        let strAmount = number.string(from: NSNumber(value: amount))
        return String(format: "%@ %@",strAmount!, unit_name)
    }
    
    static func stringVietnameseMoneyFormatWithNumberInt(amount:Int, unit_name :String = "")->(String){
        let number = NumberFormatter()
        number.usesGroupingSeparator = true
        number.groupingSeparator = "."
        number.groupingSize = 3
        
        let strAmount = number.string(from: NSNumber(value: amount))
        return String(format: "%@ %@",strAmount!, unit_name)
    }
    
    func addition<T: Numeric>(a: T, b: T) -> T
    {
        return a + b
    }
    
    static func parseDateToString(date : Date) -> String{
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd/MM/yyyy"
        
        
        let dateString = dateformat.string(from: date as Date)
        //println(dateString)
        return dateString
    }
    
    static func getDayOfWeek(today: String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    static func getWeekOfYear(today: String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let week = myCalendar.component(.weekOfYear, from: todayDate)
        return week
    }
    
    static func getCurrentMonth(date: Date) -> Int {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "MM"
        
        
        let dateString = dateformat.string(from: date as Date)
        //println(dateString)
        return Int(dateString)!
    }
    
    static func getCurrentDay(date: Date) -> Int {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd"
        
        
        let dateString = dateformat.string(from: date as Date)
        //println(dateString)
        return Int(dateString)!
    }
    
    static func getCurrentYear(date: Date) -> Int {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy"
        
        
        let dateString = dateformat.string(from: date as Date)
        //println(dateString)
        return Int(dateString)!
    }
    
    static func secondToMinuteHour(value:Int) -> String {
        var result = ""
        
        if value >= 3600 {
            let hour = value / 3600
            let minute = (value % 3600) / 60
            let second = minute % 60
            
            let hourString = (hour < 10) ? "0\(hour)" : "\(hour)"
            let minutetring = (minute < 10) ? "0\(minute)" : "\(minute)"
            let secondString = (second < 10) ? "0\(second)" : "\(second)"
            
            result = "\(hourString):\(minutetring):\(secondString)"
        }
        else if value  < 3600 && value >= 60 {
            let minute = (value % 3600) / 60
            let second = minute % 60
            
            let minutetring = (minute < 10) ? "0\(minute)" : "\(minute)"
            let secondString = (second < 10) ? "0\(second)" : "\(second)"
            
            result = "\(minutetring):\(secondString)"
        }
        else {
            
            let secondString = (value < 10) ? "0\(value)" : "\(value)"
            
            result = "00:\(secondString)"
        }
        
        return result
    }
    
    static func formatDate(date: Date) -> String{
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd/MM/yyyy"
           return dateFormatter.string(from: date)
       }
    
//    static func getFullLink(link: String) -> String{
//        dLog("================ Link " + ManageCacheObject.getGeneralConfig().ads_domain)
//        return String(format: "%@%@", ManageCacheObject.getGeneralConfig().ads_domain, link).encodeUrl()!
//
//    }
//    static func getFullMediaLink(string:String) -> String {
//        return (ManageCacheObject.getGeneralConfig().ads_domain + string).encodeUrl()!
//    }

}

