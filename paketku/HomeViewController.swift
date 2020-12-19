//
//  HomeViewController.swift
//  paketku
//
//  Created by Natalia Fellyana on 16/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var txtNoResi: UITextField!
    @IBOutlet weak var btnTrack: UIButton!
    
    @IBOutlet weak var textUsername: UIButton!
    
    @IBOutlet weak var btnPilihKurir: UIButton!
    @IBOutlet var btnKurir: [UIButton]!
    
    @IBOutlet weak var btnPilihKurirmu: UIButton!
    enum couriers : String {
        case JnT = "JnT"
        case JNE = "JNE"
        case Tiki = "Tiki"
        case SiCepat = "SiCepat"
        case NinjaExpress = "Ninja Express"
        case Wahana = "Wahana"
        case PosIndonesia = "POS Indonesia"
    }
    
    var context:NSManagedObjectContext!
    
    var jsonData: CekResi?
    var selectedCourier: String?
    var showCourier : String?
    var nomorResi: String?

    @IBOutlet var btnCourier: [UIButton]!
    
    @IBOutlet weak var tfAWB: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let barcodeImage = UIImage(named: "barcode2")
        addLeftImage(textfiled: txtNoResi, image: barcodeImage!)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        txtNoResi.text = nomorResi
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        homeUI()
    }
    
    func homeUI(){
        //mainBackgroundView.layer.cornerRadius = 30
        mainBackgroundView.roundCorners([.bottomLeft,.bottomRight], radius: 30)
        mainBackgroundView.clipsToBounds = true
        
        //profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        //profilePicture.clipsToBounds = true
        
        profilePicture.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profilePicture.addGestureRecognizer(tapRecognizer)
        
        UserDefaultsHelper.instance.handleUser()
        if(UserDefaultsHelper.instance.currentUser?.username == nil){
            textUsername.setTitle("Hi, Guest!", for: .normal)
        }
        else
        {
            textUsername.setTitle("Hi, \(UserDefaultsHelper.instance.currentUser?.username as! String)!", for: .normal)
        }
        
        btnTrack.layer.cornerRadius = 20
        txtNoResi.layer.cornerRadius = 10
        btnPilihKurir.layer.cornerRadius = 10
        btnKurir.forEach{ (btn) in
            btn.layer.cornerRadius = 10
        }
    }
    
    func addLeftImage(textfiled: UITextField, image: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height))
        
        leftImageView.image = image
        textfiled.leftView = leftImageView
        textfiled.leftViewMode = .always
        
        
        
    }
    @objc func imageTapped(recognizer: UITapGestureRecognizer) {
        print("Image was tapped")
        UserDefaultsHelper.instance.handleUser()
        if(UserDefaultsHelper.instance.currentUser?.username == nil){
            performSegue(withIdentifier: "loginPage", sender: self)
        }
        else{
            performSegue(withIdentifier: "profileSegue", sender: self)
        }
    }
    
    @IBAction func btnSelectCourier(_ sender: UIButton) {
        toggleButtons()
    }
    
    
    
    
    @IBAction func tappedCourier(_ sender: UIButton) {
        guard  let title = sender.currentTitle, let courier = couriers(rawValue: title) else {
            return
        }
        
        switch courier {
        case .JnT:
            showCourier = "JnT"
            selectedCourier = "jnt"
        case .JNE:
            showCourier = "JNE"
            selectedCourier = "jne"
        case .Tiki:
            showCourier = "Tiki"
            selectedCourier = "tiki"
        case .SiCepat:
            showCourier = "Si Cepat"
            selectedCourier = "sicepat"
        case .NinjaExpress:
            showCourier = "Ninja Express"
            selectedCourier = "ninja"
        case .Wahana:
            showCourier = "Wahana"
            selectedCourier = "wahana"
        case .PosIndonesia:
            showCourier = "POS Indonesia"
            selectedCourier = "pos"
        }
        toggleButtons()
        btnPilihKurirmu.setTitle(showCourier!, for: .normal)
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
        UserDefaultsHelper.instance.handleUser()
        loadData(awb!, selectedCourier!)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "trackSegue"){
            let destination = segue.destination as! DetailPaketViewController
            destination.jsonData = self.jsonData
        }
    }
    
    @IBAction func unwindSegue(_ sender : UIStoryboardSegue){
        
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
            
                        
                        //                    self.saveShipment(awb: awb, courier: courier)
                        self.performSegue(withIdentifier: "trackSegue", sender: self)
                }
    
                
            })
            task.resume()
        
        }
    
    func saveShipment(awb: String, courier:String) {
        let addShipment = NSEntityDescription.insertNewObject(forEntityName: "Shipment", into: context) as! Shipment
        addShipment.awb = awb
        addShipment.courier = courier
        
        do {
            try context.save()
            print("Save shipment success")
        } catch {
            print("Save shipment failed")
        }
    }
    
    func showAlert(title: String,message: String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let yaAction = UIAlertAction(title: "Mengerti", style: .default, handler: nil)


            alert.addAction(yaAction)
            present(alert,animated: true,completion: nil)
        }
    
    func toggleButtons(){
        btnCourier.forEach {(button) in
            
            UIView.animate(withDuration: 0.5, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func unwindFromScanner (_ segue: UIStoryboardSegue){}
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIView{
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
       let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
