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
    
    func load(with person: User) {
        nameLabel.text = person.name
        imageViewAvatar.kf.indicatorType = .activity
        if let id = person.id {
            let urlString = String(format: API.imageUrl.rawValue, id)
            let url = URL(string: urlString)
            imageViewAvatar.kf.setImage(with: url, options: [.cacheOriginalImage])
        }
    }

}
