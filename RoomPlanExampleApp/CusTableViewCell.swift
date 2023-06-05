//
//  CusTableViewCell.swift
//  RoomPlanExampleApp
//
//  Created by Дарья Шубич on 5.06.23.
//  Copyright © 2023 Apple. All rights reserved.
//

import UIKit

class CusTableViewCell: UITableViewCell {
    var delegate: ClickDelegate?
        var cellIndex: IndexPath?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBAction func buttonAction(_ sender: UIButton){
        delegate?.clicked(cellIndex!.row)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
