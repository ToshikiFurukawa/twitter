//
//  TimelineTableViewCell.swift
//  Twitter
//
//  Created by 福田涼介 on 12/22/15.
//  Copyright © 2015 Ryo. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell  {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var timeline: TimeLine!  {
        didSet  {
            updateUI()
        }
    }
    
    private func updateUI() {
        usernameLabel.text = timeline.user["name"]  as? String
        tweetLabel.text = timeline.tweetText
        Helper.AsyncLoadProfileImage(timeline.user["profile_image_url"] as! String, imageView: profileImageView)
    }
        override func layoutSubviews() {
            super.layoutSubviews()
            
            profileImageView.layer.cornerRadius = 4
            profileImageView.clipsToBounds  = true

    }
    
    
}