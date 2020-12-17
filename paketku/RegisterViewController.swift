//
//  RegisterViewController.swift
//  paketku
//
//  Created by Kendra Arsena on 17/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirm: UITextField!
    
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        let username = txtUsername.text!
        let email = txtEmail.text!
        let password = txtPassword.text!
        let confirm = txtConfirm.text!
        
        if (username.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
            showAlert(title: "Error", message: "All field must be filled!")
        } else if (username.count < 4 || username.count > 12) {
            showAlert(title: "Error", message: "Username length between 4 and 12")
        } else if (!email.contains("@") || !email.hasSuffix(".com")) {
            showAlert(title: "Error", message: "Email must contains @ and ends with .com")
        } else if (password.count < 4 || password.count > 12) {
            showAlert(title: "Error", message: "Password length between 4 and 12")
        } else if (confirm != password) {
            showAlert(title: "Error", message: "Confirm password does not match with your password")
        } else {
            saveToCD()
            performSegue(withIdentifier: "goToLogin", sender: self)
        }
    }
    
    func saveToCD(){
        let username = txtUsername.text!
        let email = txtEmail.text!
        let password = txtPassword.text!
        
        let addProfile = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
        addProfile.username = username
        addProfile.password = password
        addProfile.email = email
        
        do {
            try context.save()
        } catch {
            print("Save Failed")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
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
