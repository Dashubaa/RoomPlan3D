//
//  InfoViewController.swift
//  RoomPlanExampleApp
//
//  Created by Дарья Шубич on 1.06.23.
//  Copyright © 2023 Apple. All rights reserved.
//

import UIKit
import RealmSwift
class InfoViewController: UIViewController {
   
    var infoitem: Room!
    @IBOutlet var nameOutlet: UILabel!
    @IBOutlet var clientOutlet: UILabel!
    @IBOutlet var addressOutlet: UILabel!
    @IBOutlet var desOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameOutlet.text = infoitem.roomName ?? "no data"
        clientOutlet.text = infoitem.client ?? "no data"
        addressOutlet.text = infoitem.adress ?? "no data"
        desOutlet.text = infoitem.descriptionOfRoom ?? "no data"
        
        // Do any additional setup after loading the view.
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
