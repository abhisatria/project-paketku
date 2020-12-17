//
//  HomeViewController.swift
//  paketku
//
//  Created by Natalia Fellyana on 16/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    enum couriers : String {
        case JnT = "JnT"
        case JNE = "JNE"
        case Tiki = "Tiki"
        case SiCepat = "SiCepat"
        case NinjaExpress = "Ninja Express"
        case Wahana = "Wahana"
        case PosIndonesia = "POS Indonesia"
    }
    
    var jsonData: CekResi?
    var selectedCourier: String?

    @IBOutlet var btnCourier: [UIButton]!
    
    @IBOutlet weak var tfAWB: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSelectCourier(_ sender: UIButton) {
        btnCourier.forEach {(button) in
            
            UIView.animate(withDuration: 0.5, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    @IBAction func tappedCourier(_ sender: UIButton) {
        guard  let title = sender.currentTitle, let courier = couriers(rawValue: title) else {
            return
        }
        
        switch courier {
        case .JnT:
            print("JnT")
            selectedCourier = "jnt"
        case .JNE:
            print("JNE")
            selectedCourier = "jne"
        case .Tiki:
            print("Tiki")
            selectedCourier = "tiki"
        case .SiCepat:
            print("Si Cepat")
            selectedCourier = "sicepat"
        case .NinjaExpress:
            print("Ninja Express")
            selectedCourier = "ninja"
        case .Wahana:
            print("Wahana")
            selectedCourier = "wahana"
        case .PosIndonesia:
            print("POS Indonesia")
            selectedCourier = "pos"
        }
    }
    
    
    @IBAction func btnTrack(_ sender: Any) {
        let awb = tfAWB.text as String?
        if awb == ""{
            showAlert(title: "Perhatian", message: "Anda harus mengisi nomor resi")
            return
        }
        guard (selectedCourier != nil) else{
            showAlert(title: "Perhatian", message: "Anda harus memilih kurir")
            return
        }
        
        loadData(awb!, selectedCourier!)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "trackSegue"){
            let destination = segue.destination as! DetailPaketViewController
            destination.jsonData = self.jsonData
        }
    }
    
    func loadData(_ awb: String, _ courier: String) {
            
            var request = URLRequest(url: ApiRequest.init(awb: awb, courier: courier).resourceURL)
            
            request.httpMethod = "GET"
            
            let task =  URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
    
                do{
                    self.jsonData = try JSONDecoder().decode(CekResi.self, from: data!)
                }
                catch{
                    print("json failed \(error.localizedDescription)")
                }
    
                guard let json = self.jsonData else {
                    return
                }
    
                print(json.status)
                print(json.message)
                
                DispatchQueue.main.async {
                    
                    if json.status == 400{
                        self.showAlert(title: "Terjadi Kesalahan", message: "\(self.jsonData?.message) Periksa kembali nomor resi dan kurir anda")
                    }
                    
                    self.performSegue(withIdentifier: "trackSegue", sender: self)
                    
                }
    
                
            })
            task.resume()
        
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
