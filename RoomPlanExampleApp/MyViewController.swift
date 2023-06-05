//
//  MyViewController.swift
//  RoomPlanExampleApp
//
//  Created by Дарья Шубич on 5.06.23.
//  Copyright © 2023 Apple. All rights reserved.
//

import UIKit
import RealmSwift
protocol ClickDelegate {
    func clicked(_ row: Int)
}
class MyViewController: UIViewController{
    let realm = try! Realm()
    var allRooms: Results<Room>?
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        allRooms = realm.objects(Room.self)
        tableView = UITableView(frame: self.view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "CusTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 44
        self.view = tableView
        // Do any additional setup after loading the view.
    }
   
}
extension MyViewController: ClickDelegate {
    func clicked(_ row: Int) {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        newVC.infoitem = allRooms?[row]
        self.present(newVC, animated: true)
    }
}
extension MyViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRooms?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CusTableViewCell
        cell.nameLabel.text = allRooms?[indexPath.row].roomName
        cell.cellIndex = indexPath
        cell.delegate = self
        return cell
    }
}
extension MyViewController: UITableViewDelegate{
   func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteItem = allRooms![indexPath.row]
            let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
                    try! self.realm.write {
                        self.realm.delete(deleteItem)
                    tableView.deleteRows(at: [indexPath], with: .left)
                }
            }
            
            let swipe = UISwipeActionsConfiguration(actions: [delete])
            return swipe
    }

}
