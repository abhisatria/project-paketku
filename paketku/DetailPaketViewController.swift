//
//  DetailPaketViewController.swift
//  paketku
//
//  Created by Garry on 16/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//

import UIKit

struct DummyDetail{
    var title: String?
    var desc: String?
    var imgInfo: UIImage?
}

class DetailPaketViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var backgroundBox: UIView!
    @IBOutlet weak var backgroundButtonInfo: UIView!
    @IBOutlet weak var txtButtonInfo: UILabel!
    
    @IBOutlet weak var btnBookmark: UIButton!
    @IBOutlet weak var txtResi: UILabel!
    @IBOutlet weak var txtTujuan: UILabel!
    @IBOutlet weak var txtStatus: UILabel!
    @IBOutlet weak var txtDate: UILabel!
    var circleFill = UIImage(systemName: "circle.fill")
    var circle = UIImage(systemName: "circle")
    var arrDummyDetail = [DummyDetail]()
    
    var jsonData: CekResi?
    
    
    
    @IBOutlet weak var tvDetail: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tvDetail.dataSource = self
        tvDetail.separatorStyle = .none
        
        setViewUI()
        
        setCardData()
    }
    
    
    func setViewUI(){
        //BackgroundBox radius & dropshadow
        backgroundBox.layer.cornerRadius = 10
        backgroundBox.layer.shadowColor = UIColor.black.cgColor
        backgroundBox.layer.shadowOffset = CGSize(width: 2, height: 2)
        backgroundBox.layer.shadowOpacity = 0.7
        backgroundBox.layer.shadowRadius = 4.0
        //BackgroundBox status
        backgroundButtonInfo.layer.cornerRadius = 10
        //LOGIC taruh disini ya mas
        //if status == onProcess
        self.backgroundButtonInfo.backgroundColor = #colorLiteral(red: 1, green: 0.5411764706, blue: 0, alpha: 1)
        txtButtonInfo.text = ""
        
        let image = UIImage(named: "bookmark")
        let imageFilled = UIImage(named: "bookmarked")
        btnBookmark.setImage(image, for: .normal)
        btnBookmark.setImage(imageFilled, for: .selected)
        
        if(UserDefaultsHelper.instance.currentUser?.username) != nil{
            if (UserDefaultsHelper.instance.isShipmentAlreadySaved(awb: (jsonData?.data?.summary.awb)!)){
                btnBookmark.isSelected = true
            }
            else {
                btnBookmark.isSelected = false
            }
        }
        
        // else
        //self.backgroundButtonInfo.backgroundColor = #colorLiteral(red: 0.4156862745, green: 0.3254901961, blue: 0.8039215686, alpha: 1)
        //txtButtonInfo.text = "Delivered"
    }
    
    
    
    func setCardData(){
        self.txtResi.text = self.jsonData?.data?.summary.awb
        self.txtTujuan.text = self.jsonData?.data?.detail.destination.capitalized
        self.txtStatus.text = self.jsonData?.data?.summary.status.capitalized
        
        if(txtStatus.text == "Delivered"){
            backgroundButtonInfo.backgroundColor = #colorLiteral(red: 0.4156862745, green: 0.3254901961, blue: 0.8039215686, alpha: 1)
        }else{
            backgroundButtonInfo.backgroundColor = #colorLiteral(red: 1, green: 0.5411764706, blue: 0, alpha: 1)
        }
        
        self.txtDate.text = dateFormatter(date: self.jsonData?.data?.summary.date)
        
        self.tvDetail.reloadData()
    }
    
    
    func dateFormatter(date:String?) -> String{
        let inputFormat = DateFormatter()
        inputFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let inputDate = inputFormat.date(from: date ?? "")
        
        inputFormat.dateFormat = "dd MMM yyyy H:mm a"
        
        
        
        return inputFormat.string(from: inputDate ?? Date())
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonData?.data?.history.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as! DetailTableViewCell
        let histories = jsonData?.data!.history[indexPath.row]
        cell.txtDesc.text = dateFormatter(date: histories?.date)
        cell.txtTitle.text = histories?.desc.capitalized
        if(indexPath.row == 0){
            cell.imgInfo.image = circleFill
        }else{
            cell.imgInfo.image = circle
        }
        
        return cell
    }
    
    @IBAction func btnSave(_ sender: Any) {
        var namakurir : String?
        switch jsonData?.data?.summary.courier {
           case "J&T Express":
               namakurir = "jnt"
           case "JNE Express":
               namakurir = "jne"
           case "Tiki":
               namakurir = "tiki"
           case "SiCepat":
               namakurir = "sicepat"
           case "Ninja Express":
               namakurir = "ninjaxpress"
           case "Wahana Express":
               namakurir = "ninjaxpress"
           case "Pos Indonesia":
               namakurir = "posindo"
           default :
               namakurir = nil
           }
        if UserDefaultsHelper.instance.currentUser?.username != nil{
            if (UserDefaultsHelper.instance.isShipmentAlreadySaved(awb: (jsonData?.data?.summary.awb)!)){
                //unsave
                btnBookmark.isSelected = false
                UserDefaultsHelper.instance.deleteData(awb: (jsonData?.data?.summary.awb)!, email: UserDefaultsHelper.instance.currentUser!.email!)
            }
            else {
                btnBookmark.isSelected = true
                UserDefaultsHelper.instance.addUserShipment(awb: (jsonData?.data?.summary.awb)!, courier: namakurir!)
            }
        }
        else{
            showAlert(title: "Gagal", message: "Anda harus melakukan login terlebih dahulu")
        }
    }
    
    func showAlert(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let yaAction = UIAlertAction(title: "Mengerti", style: .default, handler: nil)


        alert.addAction(yaAction)
        present(alert,animated: true,completion: nil)
    }
    
    
        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
