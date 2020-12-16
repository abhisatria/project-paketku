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
    var circleFill = UIImage(systemName: "circle.fill")
    var circle = UIImage(systemName: "circle")
    var arrDummyDetail = [DummyDetail]()
    
    func initDummy(){
        arrDummyDetail.append(DummyDetail(title: "Kurir ganti rugi", desc: "15-12-2020", imgInfo: circleFill))
        arrDummyDetail.append(DummyDetail(title: "[MH JAKARTA] Paket anda hilang", desc: "15-12-2020 16:42", imgInfo: circle))
        arrDummyDetail.append(DummyDetail(title: "RECEIVED AT WAREHOUSE[JAKARTA]", desc: "15-12-2020 16:42", imgInfo: circle))
        arrDummyDetail.append(DummyDetail(title: "RECEIVED AT WAREHOUSE[JAKARTA]", desc: "15-12-2020 16:42", imgInfo: circle))
    }
    
    @IBAction func btnSave(_ sender: Any) {
        
    }
    
    @IBOutlet weak var tvDetail: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDummy()
        tvDetail.dataSource = self
        tvDetail.separatorStyle = .none
        setViewUI()
        
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
        txtButtonInfo.text = "In Process"
        // else
        //self.backgroundButtonInfo.backgroundColor = #colorLiteral(red: 0.4156862745, green: 0.3254901961, blue: 0.8039215686, alpha: 1)
        //txtButtonInfo.text = "Delivered"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDummyDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as! DetailTableViewCell
        let dummy = arrDummyDetail[indexPath.row]
        cell.txtDesc.text = dummy.desc
        cell.txtTitle.text = dummy.title
        cell.imgInfo.image = dummy.imgInfo
        return cell
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
