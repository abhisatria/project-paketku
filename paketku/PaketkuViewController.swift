//
//  PaketkuViewController.swift
//  paketku
//
//  Created by Garry on 16/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//
struct Dummy{
    var pengirim: String?
    var resi: String?
    var penerima: String?
    var thumbnail: String?
}
import UIKit

class PaketkuViewController: UIViewController, UITableViewDataSource {
    var arrDummy = [Dummy]()
        
    @IBOutlet weak var tvPaketku: UITableView!
    //@IBOutlet weak var viewCard: UIView!
    func testDummy(){
            arrDummy.append(Dummy(pengirim: "Garry Stevens", resi: "TJR48587923129", penerima: "Kick Avenue HQ", thumbnail: "jnt"))
            arrDummy.append(Dummy(pengirim: "Yesus Kristus", resi: "TJR48587923129", penerima: "Sidartha Gautama", thumbnail: "jne"))
            arrDummy.append(Dummy(pengirim: "Uzumaki Naruto", resi: "TJR48587923129", penerima: "Weabweab Wibu", thumbnail: "jne"))
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            testDummy()
            tvPaketku.dataSource = self
            tvPaketku.separatorStyle = .none
            //viewCard.layer.cornerRadius = 10

            // Do any additional setup after loading the view.
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrDummy.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cells") as! PaketTableViewCell
            let dummy = arrDummy[indexPath.row]
            cell.imgLogo.image = UIImage(named: arrDummy[indexPath.row].thumbnail as! String)
            cell.txtResi.text = arrDummy[indexPath.row].resi
            cell.txtPengirim.text = arrDummy[indexPath.row].pengirim
            cell.txtPenerima.text = dummy.penerima
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
