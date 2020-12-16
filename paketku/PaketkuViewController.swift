//
//  PaketkuViewController.swift
//  paketku
//
//  Created by Garry on 16/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//
struct Dummy{
    var product: String?
    var resi: String?
    var status: String?
    var thumbnail: String?
}
import UIKit

class PaketkuViewController: UIViewController, UITableViewDataSource {
    var arrDummy = [Dummy]()
        
    @IBOutlet weak var tvPaketku: UITableView!
    func testDummy(){
            arrDummy.append(Dummy(product: "1", resi: "TJR123456789", status: "On Transit", thumbnail: "jne"))
            arrDummy.append(Dummy(product: "2", resi: "TJR123456789", status: "Delivered", thumbnail: "jnt"))
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            testDummy()
            tvPaketku.dataSource = self

            // Do any additional setup after loading the view.
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrDummy.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cells") as! PaketTableViewCell
            //let dummy = arrDummy[indexPath.row]
            cell.imgLogo.image = UIImage(named: arrDummy[indexPath.row].thumbnail as! String)
            cell.txtProduct.text = arrDummy[indexPath.row].product
            cell.txtResi.text = arrDummy[indexPath.row].resi
            cell.txtStatus.text = arrDummy[indexPath.row].status
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
