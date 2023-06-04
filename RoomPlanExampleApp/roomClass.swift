//
//  roomClass.swift
//  RoomPlanExampleApp
//
//  Created by Дарья Шубич on 29.05.23.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation
import RealmSwift

class Room: Object {
    @objc dynamic var roomName: String?
    @objc dynamic var urlString: String? = nil
    @objc dynamic var adress: String?
    @objc dynamic var descriptionOfRoom: String?
    @objc dynamic var client: String?
}

var rooms = Room()
