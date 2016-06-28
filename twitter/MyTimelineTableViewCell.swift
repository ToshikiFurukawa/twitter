//
//  MyTimelineTableViewCell.swift
//  Twitter
//
//  Created by 福田涼介 on 12/22/15.
//  Copyright © 2015 Ryo. All rights reserved.
//

import UIKit

class MyTimelineTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var tweet: Tweet!  {
        didSet {
            updataUI()
        }
    }
    
    private func updataUI()  {
        
        Helper.AsyncLoadProfileImage(tweet.user["profile_image_url"] as! String, imageView: profileImageView)
        usernameLabel.text = tweet.user["name"] as? String
        tweetLabel.text = tweet.tweetText
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.layer.cornerRadius = 4
        profileImageView.clipsToBounds = true
    }
    
}
