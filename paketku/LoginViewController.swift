//
//  LoginViewController.swift
//  paketku
//
//  Created by Kendra Arsena on 17/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var context:NSManagedObjectContext!
    
    var arr = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let username = txtUsername.text!
        let password = txtPassword.text!
        
        if (username.isEmpty || password.isEmpty) {
            showAlert(title: "Error", message: "All field must be filled")
        } else {
            checkData()
            if arr.count == 0 {
                showAlert(title: "Error", message: "You have to register first!")
            }
        }
    }
    
    func checkData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            arr = try context.fetch(request) as! [User]
        } catch {
            print("Fetch Failed")
        }
        
        var emailcheck:String?
        var passwordcheck:String?
        let emailinput = txtUsername.text!
        let passwordinput = txtPassword.text!
        var count = 0
        for data in arr{
            emailcheck = (data.value(forKey: "email") as! String)
            passwordcheck = (data.value(forKey: "password") as! String)
            if emailinput == emailcheck && passwordinput == passwordcheck {
                UserDefaults.standard.set(data.value(forKey: "username") as! String, forKey: "username")
                UserDefaults.standard.set(data.value(forKey: "email") as! String, forKey: "email")
                UserDefaultsHelper.instance.handleUser()
                
                performSegue(withIdentifier: "loginSuccess", sender: self)
                print(UserDefaultsHelper.instance.currentUser)
            } else if arr.count-1 == count{
                showAlert(title: "Error", message: "Username or password is invalid")
            }
            count += 1
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
