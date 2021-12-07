//
//  Helper.swift
//
//  Created by Demyanchuk Dmitry on 24.01.17.
//  Copyright © 2017 qascript@mail.ru All rights reserved.
//


import UIKit
import SystemConfiguration
import AVFoundation

class Helper {

    static func isInternetAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
    }
    
    static func image(with image: UIImage?, scaledTo newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, _: false, _: 0.0)
        image?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
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
    
    static func rotateImage(image: UIImage) -> UIImage {
        
        if (image.imageOrientation == UIImage.Orientation.up ) {
            
            return image
        }
        
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        let copy = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return copy!
    }
    
//    static func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
//
//        let body = NSMutableData();
//
//        if parameters != nil {
//
//            for (key, value) in parameters! {
//
//                body.appendString(string: "--\(boundary)\r\n")
//                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//                body.appendString(string: "\(value)\r\n")
//            }
//        }
//
//        let filename = "profile.jpg"
//        let mimetype = "image/jpg"
//
//        body.appendString(string: "--\(boundary)\r\n")
//        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
//        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
//        body.append(imageDataKey as Data)
//        body.appendString(string: "\r\n")
//
//        body.appendString(string: "--\(boundary)--\r\n")
//
//        return body
//    }
    
    static func generateBoundaryString() -> String {
        
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    static func generateThumbnail(path: URL) -> UIImage? {
        do {
            let asset = AVURLAsset(url: path, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            return thumbnail
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
        }
    }
    
    static func thumbnailFromVideoPath(_ path: URL) -> UIImage {
        let asset = AVURLAsset(url: path, options: nil)
        let gen = AVAssetImageGenerator(asset: asset)
        gen.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(0.0, preferredTimescale: 600)
        var actualTime = CMTimeMake(value: 0, timescale: 0)
        let image: CGImage
        do {
            image = try gen.copyCGImage(at: time, actualTime: &actualTime)
            let thumbnail = UIImage(cgImage: image)
            return thumbnail
        } catch { }
        return UIImage()
    }
}
