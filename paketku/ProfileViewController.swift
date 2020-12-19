//
//  ProfileViewController.swift
//  paketku
//
//  Created by Garry on 18/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var cardPurpleView: UIView!
    @IBOutlet weak var cardWhiteView: UIView!
    @IBOutlet weak var cardProfileView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblTotalResi: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setValue()
        // Do any additional setup after loading the view.
    }
    
    func setValue(){
        UserDefaultsHelper.instance.handleUser()
        print(UserDefaultsHelper.instance.currentUser)
        lblName.text = UserDefaultsHelper.instance.currentUser?.username!
        lblEmail.text = UserDefaultsHelper.instance.currentUser?.email!
        lblTotalResi.text = "69"
    }
    
    func setUI(){
//        cardPurpleView.roundCorners([.topLeft, .topRight], radius: 10,boolean: false)
        
        cardProfileView.layer.cornerRadius = 13
        
        cardPurpleView.layer.cornerRadius = 10
        cardPurpleView.layer.shadowColor = UIColor.black.cgColor
        cardPurpleView.layer.shadowOffset = CGSize(width: 2, height: 2)
        cardPurpleView.layer.shadowOpacity = 0.7
        cardPurpleView.layer.shadowRadius = 4.0
        
        
        
        cardWhiteView.roundCorners([.bottomLeft , .bottomRight], radius: 10, boolean: true)
        cardWhiteView.layer.shadowColor = UIColor.black.cgColor
        cardWhiteView.layer.shadowOffset = CGSize(width: 1, height: 2)
        cardWhiteView.layer.shadowOpacity = 0.7
        cardWhiteView.layer.shadowRadius = 3.0
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

extension UIView{
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat, boolean: Bool){
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
       let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
