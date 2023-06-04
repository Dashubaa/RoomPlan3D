//
//  GalleryTableViewController.swift
//  RoomPlanExampleApp
//
//  Created by Дарья Шубич on 1.06.23.
//  Copyright © 2023 Apple. All rights reserved.
//

import UIKit
import RealmSwift
import QuickLook

class GalleryTableViewController: UITableViewController, GalleryCellDelegate {

    let realm = try! Realm()
    var allRooms: Results<Room>?
    override func viewDidLoad() {
        super.viewDidLoad()
        allRooms = realm.objects(Room.self)
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allRooms?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let сell = tableView.dequeueReusableCell(withIdentifier: "сell", for: indexPath)
        сell.textLabel?.text = allRooms?[indexPath.row].roomName// Привязка индекса ячейки
        return сell
    }
    func infoButtonTapped(at indexPath: IndexPath) {
        if let infoViewController = storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController {
                  infoViewController.selectedIndexPath = indexPath
                  navigationController?.pushViewController(infoViewController, animated: true)
              }
    }
    
    // Delete
    
        override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
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


