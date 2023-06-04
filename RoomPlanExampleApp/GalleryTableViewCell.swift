//
//  GalleryTableViewCell.swift
//  RoomPlan3D
//
//  Created by Дарья Шубич on 2.06.23.
//  Copyright © 2023 Apple. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {
    weak var delegate: GalleryCellDelegate?
    @IBOutlet var roomNameOutlet: UILabel!
    var indexPath: IndexPath?
   
    @IBAction func infoButtonTapped(_ sender: Any) {
        if let indexPath = indexPath {
                    delegate?.infoButtonTapped(at: indexPath)
                }
      }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func refresh(_ model: String?){
        roomNameOutlet?.text = model ?? ""
    }
}
protocol GalleryCellDelegate: AnyObject {
    func infoButtonTapped(at indexPath: IndexPath)
}
