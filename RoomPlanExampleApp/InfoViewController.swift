//
//  InfoViewController.swift
//  RoomPlanExampleApp
//
//  Created by Дарья Шубич on 1.06.23.
//  Copyright © 2023 Apple. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    var selectedIndexPath: IndexPath?
    @IBOutlet var nameLabel: UILabel!
    var nameText: String = ""
    func updateInfo(_ name: String) {
        self.nameText = name
        print(nameText)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
