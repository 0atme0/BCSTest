//
//  NewsTableViewCell.swift
//  BCSTest
//
//  Created by Andrey Ildyakov on 16.07.17.
//  Copyright © 2017 Andrey Ildyakov. All rights reserved.
//

import UIKit
import AlamofireImage

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell (news:News) {
        newsText.text = news.text
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
            size: newsImage.frame.size,
            radius: 20.0
        )
        if !news.imageLink.isEmpty {
            newsImage.af_setImage(
                withURL: URL(string: news.imageLink)!,
                placeholderImage: UIImage(named:"noImage"),
                filter: filter)
        } else {
            newsImage.image = UIImage(named:"noImage")
        }

//        newsImage.layer.cornerRadius = 17
//        newsImage.layer.masksToBounds = true
//        self.layoutSubviews()
    }
    
    
    
}
