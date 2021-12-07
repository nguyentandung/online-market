//
//  BrandViewController.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 04/27/21.
//

import UIKit

class BrandViewController: UIViewController {
    
    @IBOutlet weak var tbl_setData: UITableView!
    
    var BrandList = ["KIA"]
    
    var ModelList = ["Kia Moning","SELTOS","SOLUTO","CERATO"]
    var ProductLocationList = ["VN","Hàn Quốc","Mỹ"]
    
    var kmList = [100,200,300,500,1000,1500,2000]
    var statusList = ["Mới","Đã sử dụng nhưng ít","Đã sử dụng nhiều","Cũ"]
    var FuleList = ["Xăng","Dầu","Điện"]
    
    var CapacityList = ["1","2","3","4","5","6","7"]
    var colorList = ["Trắng","Đỏ","Vàng","Xanh","Xám","Đen","Xanh dương","Khác"]
    
    
    var data = 0
    
    var delegate : GetDataPostDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    

}

extension BrandViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.data == 0 {
            return BrandList.count
        }else if self.data == 1 {
            return ModelList.count
        }
        else if self.data == 2{
            return ProductLocationList.count
        }else if self.data == 3{
            return kmList.count
            
        }
        else if self.data == 4{
            return statusList.count
        }
        else if self.data == 5{
            return FuleList.count
        }
        else if self.data == 6{
            return CapacityList.count
        
        }else{
            return colorList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if self.data == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BrandListTableViewCell", for: indexPath) as! BrandListTableViewCell
            cell.lbl_brandName.text = BrandList[indexPath.row]
            return cell
        }else if self.data == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ModelListTableViewCell", for: indexPath) as! ModelListTableViewCell
            cell.lbl_modelName.text = ModelList[indexPath.row]
            return cell
        }
        else if self.data == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductLocationListTableViewCell", for: indexPath) as! ProductLocationListTableViewCell
            cell.lbl_productionLocation.text = ProductLocationList[indexPath.row]
            return cell
        }else if self.data == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "KmUsedTableViewCell", for: indexPath) as! KmUsedTableViewCell
            cell.lbl_kmUsed.text = "\(kmList[indexPath.row])"
            return cell
            
        }
        else if self.data == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatusTableViewcell", for: indexPath) as! StatusTableViewcell
            cell.lbl_statusName.text = statusList[indexPath.row]
            return cell
        }
        else if self.data == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FuelTableViewCell", for: indexPath) as! FuelTableViewCell
            cell.lbl_SuelName.text = FuleList[indexPath.row]
            return cell
        }
        else if self.data == 6{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CapacityTableViewCell", for: indexPath) as! CapacityTableViewCell
            cell.lbl_Capacityname.text = CapacityList[indexPath.row]
            return cell
        
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ColorTableViewCell", for: indexPath) as! ColorTableViewCell
            cell.lbl_ColorName.text = colorList[indexPath.row]
            return cell
        }
        
}
        
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.data == 0 {
            delegate?.setBrandData(text: BrandList[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        }else if self.data == 1 {
            delegate?.setModelData(text: ModelList[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        }
        else if self.data == 2{
            delegate?.setProductionData(text: ProductLocationList[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        }else if self.data == 3{
            delegate?.setkmUsedData(text: kmList[indexPath.row])
            self.navigationController?.popViewController(animated: true)
            
        }
        else if self.data == 4{
            delegate?.setStatuslData(text: statusList[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        }
        else if self.data == 5{
            delegate?.setFuellData(text: FuleList[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        }
        else if self.data == 6{
            delegate?.setCapacityData(text: CapacityList[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        
        }else{
            delegate?.setColorData(text: colorList[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}


class BrandListTableViewCell : UITableViewCell {
    @IBOutlet weak var lbl_brandName: UILabel!
}

class ModelListTableViewCell : UITableViewCell {
    @IBOutlet weak var lbl_modelName: UILabel!
}

class ProductLocationListTableViewCell : UITableViewCell {
    @IBOutlet weak var lbl_productionLocation: UILabel!
}

class KmUsedTableViewCell : UITableViewCell {
    
    @IBOutlet weak var lbl_kmUsed: UILabel!
}
class StatusTableViewcell : UITableViewCell {
    
    @IBOutlet weak var lbl_statusName: UILabel!
}
class FuelTableViewCell : UITableViewCell {
    
    @IBOutlet weak var lbl_SuelName: UILabel!
}
class CapacityTableViewCell : UITableViewCell {
    
    @IBOutlet weak var lbl_Capacityname: UILabel!
}
class ColorTableViewCell : UITableViewCell {
    
    @IBOutlet weak var lbl_ColorName: UILabel!
}

                        



