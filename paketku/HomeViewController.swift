//
//  HomeViewController.swift
//  paketku
//
//  Created by Natalia Fellyana on 16/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var txtResi: UITextField!
    @IBOutlet weak var btnTrack: UIButton!
    @IBOutlet var btnCourier: [UIButton]!
    @IBOutlet weak var mainBackgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.BackgroundUI()
        
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
    
    func BackgroundUI() {
        self.mainBackgroundView.layer.cornerRadius = 30
        self.mainBackgroundView.clipsToBounds = true
        
        btnTrack.layer.cornerRadius = 10
        
        txtResi.layer.cornerRadius = 10
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        
    }
    
    enum couriers : String {
        case JnT = "JnT"
        case JNE = "JNE"
        case Tiki = "Tiki"
        case SiCepat = "SiCepat"
        case NinjaExpress = "Ninja Express"
        case Wahana = "Wahana"
        case PosIndonesia = "POS Indonesia"
        
        
    }
    @IBAction func tappedCourier(_ sender: UIButton) {
        guard  let title = sender.currentTitle, let courier = couriers(rawValue: title) else {
            return
        }
        
        switch courier {
        case .JnT:
            print("JnT")
        case .JNE:
            print("JNE")
        case .Tiki:
            print("Tiki")
        case .SiCepat:
            print("Si Cepat")
        case .NinjaExpress:
            print("Ninja Express")
        case .Wahana:
            print("Wahana")
        case .PosIndonesia:
            print("POS Indonesia")
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

}
