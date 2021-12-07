//
//  ProtocolList.swift
//  TechresSupplier
//
//  Created by Nguyen Tan Dung on 04/24/21.
//

import UIKit

protocol DetailNewfeedDelegate {
    func showDetailPost(pos:Int)
    func showListCar()
    func showListTech()
}

protocol VideoCollectionViewCellDelegate {
    func showVideoFullScreen(videoLink:URL)
    func removeVideo(pos:Int)
}

protocol GetDataPostDelegate {
    func setBrandData(text:String)
    func setModelData(text:String)
    func setProductionData(text:String)
    func setkmUsedData(text:Int)
    func setStatuslData(text:String)
    func setFuellData(text:String)
    func setCapacityData(text:String)
    func setColorData(text:String)
}

protocol GetDataAfterChooseDelegate {
    func setData(Brand:String,Model:String,ProductionLocation:String,kmUsed:Int,Status:String,Fuel:String,Capacity:String,Color:String)
}

