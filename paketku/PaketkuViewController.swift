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

class PaketkuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        var arrResi = [CekResi]()
        var shipments = [Shipment]()
        var fetchResi: CekResi?
            
    @IBOutlet weak var gambarNoData: UIImageView!
    @IBOutlet weak var tvPaketku: UITableView!
        //@IBOutlet weak var viewCard: UIView!
        func loadCoreData(){
            
            UserDefaultsHelper.instance.handleUser()
            if UserDefaultsHelper.instance.currentUser?.username != nil{
                tvPaketku.isHidden = false
                gambarNoData.isHidden = true
                shipments = UserDefaultsHelper.instance.getUserShipment()
                self.arrResi.removeAll()
                tvPaketku.reloadData()
                for shipment in shipments{
                    loadData(awb: shipment.awb!, courier: shipment.courier!)
                }
            }
            else{
                self.arrResi.removeAll()
                tvPaketku.reloadData()
                tvPaketku.isHidden = true
                gambarNoData.isHidden = false
            }
            
        }
        override func viewWillAppear(_ animated: Bool) {
            tvPaketku.dataSource = self
            tvPaketku.delegate = self
            
            loadCoreData()
            
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //tvPaketku.delegate = self
            tvPaketku.separatorStyle = .none
            //viewCard.layer.cornerRadius = 10

            // Do any additional setup after loading the view.
        }
    
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                UserDefaultsHelper.instance.deleteData(awb: (arrResi[indexPath.row].data?.summary.awb)!, email: (UserDefaultsHelper.instance.currentUser?.email!)!)
                arrResi.remove(at: indexPath.row)
                shipments = UserDefaultsHelper.instance.getUserShipment()
                tvPaketku.reloadData()
            }
        }
    
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            if arrResi.count == shipments.count{
//                self.tvPaketku.reloadData()
//            }
            return arrResi.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cells") as! PaketTableViewCell
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
            if let a = namakurir{
                cell.imgLogo.image = UIImage(named: a)
            }
            
            cell.txtResi.text = arrResi[indexPath.row].data?.summary.awb.capitalized
            cell.txtPengirim.text = arrResi[indexPath.row].data?.detail.shipper.capitalized
            cell.txtPenerima.text = arrResi[indexPath.row].data?.detail.receiver.capitalized
            return cell
        }
    	
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        fetchResi = arrResi[indexPath.row]
        print(indexPath.row)
        performSegue(withIdentifier: "paketkuDetail", sender: self)
    }
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "paketkuDetail"){
            let destination = segue.destination as! DetailPaketViewController
            destination.jsonData = fetchResi
            
        }
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
    
            var request = URLRequest(url: ApiRequest.init(awb: awb, courier: courier).resourceURL)
    
            request.httpMethod = "GET"
    
            let task =  URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
    
                var result: CekResi?
    
                do {
                    result = try JSONDecoder().decode(CekResi.self, from: data!)
                }
                catch {
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
