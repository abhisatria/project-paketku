//
//  TrackDetailViewController.swift
//  paketku
//
//  Created by Garry on 16/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//

import UIKit

struct DummyTrack{
    var date: String?
    var desc: String?
}

class TrackDetailViewController: UIViewController, UITableViewDataSource{
    

    @IBOutlet weak var txtResi: UITextField!
    @IBOutlet weak var tvTracking: UITableView!
    
    var arrDummyTrack = [DummyTrack]()
    
    func initial(){
        arrDummyTrack.append(DummyTrack(date: "2020-10-25 00:59:00", desc: "RECEIVED AT WAREHOUSE[JAKARTA]"))
        arrDummyTrack.append(DummyTrack(date: "2020-10-25 00:59:00", desc: "RECEIVED AT WAREHOUSE[CILEGON]"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
        tvTracking.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDummyTrack.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = arrDummyTrack[indexPath.row].date
        cell?.detailTextLabel?.text = arrDummyTrack[indexPath.row].desc
        
        return cell!
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
