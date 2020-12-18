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
    var arrResi = [CekResi]()
    var shipments = [Shipment]()
        
    @IBOutlet weak var tvPaketku: UITableView!
    //@IBOutlet weak var viewCard: UIView!
    func testDummy(){
            arrDummy.append(Dummy(pengirim: "Garry Stevens", resi: "TJR48587923129", penerima: "Kick Avenue HQ", thumbnail: "jnt"))
            arrDummy.append(Dummy(pengirim: "Yesus Kristus", resi: "TJR48587923129", penerima: "Sidartha Gautama", thumbnail: "jne"))
            arrDummy.append(Dummy(pengirim: "Uzumaki Naruto", resi: "TJR48587923129", penerima: "Weabweab Wibu", thumbnail: "jne"))
        }
    func loadCoreData(){
        UserDefaultsHelper.instance.handleUser()
        print(UserDefaultsHelper.instance.currentUser)
        shipments = UserDefaultsHelper.instance.getUserShipment()
        for shipment in shipments{
            loadData(awb: shipment.awb!, courier: shipment.courier!)
        }
    }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            testDummy()
            loadCoreData()
            tvPaketku.dataSource = self
            tvPaketku.separatorStyle = .none
            //viewCard.layer.cornerRadius = 10

            // Do any additional setup after loading the view.
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrResi.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cells") as! PaketTableViewCell
            let dummy = arrDummy[indexPath.row]
            var namakurir : String?
            switch arrResi[indexPath.row].data?.summary.courier {
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
            cell.imgLogo.image = UIImage(named: namakurir as! String)
            cell.txtResi.text = arrResi[indexPath.row].data?.summary.awb
            cell.txtPengirim.text = arrResi[indexPath.row].data?.detail.shipper
            cell.txtPenerima.text = arrResi[indexPath.row].data?.detail.receiver
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
    func loadData(awb: String, courier: String) {
    
            var request = URLRequest(url: ApiRequest.init(awb: "170430045644420", courier: "jne").resourceURL)
    
            request.httpMethod = "GET"
    
            let task =  URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
    
                var result: CekResi?
    
                do{
                    result = try JSONDecoder().decode(CekResi.self, from: data!)
                }
                catch{
                    print("json failed \(error.localizedDescription)")
                }
    
                guard let json = result else {
                    return
                }
    
                
                DispatchQueue.main.async {
                    
                    self.arrResi.append(json)
                    self.tvPaketku.reloadData()
                    
                }
    
            })
            task.resume()
    
    
        }

}
