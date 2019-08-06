//
//  VDListTableViewCell.swift
//  ShowList
//
//  Created by Влад Дудин on 8/3/19.
//  Copyright © 2019 Vlad Dudin. All rights reserved.
//

import UIKit
import Kingfisher

class VDListTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Public
    
    func load(with person: User?) {
        nameLabel.text = person?.name
        guard let imageData = person?.imageData else { return }
        imageViewAvatar.image = UIImage(data: imageData)
    }

}
