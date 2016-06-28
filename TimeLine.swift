//
//  TimeLine.swift
//  Twitter
//
//  Created by 古川俊樹 on 2016/06/23.
//  Copyright © 2016年 Ryo. All rights reserved.
//

import UIKit

class TimeLine {
    
    var tweetId: Int!
    var tweetText: String!
    var user: Dictionary<String, AnyObject>!
    
    var retweet_count: Int!
    var favorite_count: Int!
    
    var imageData: NSData?
    
    init(id: Int, text: String, user: Dictionary<String, AnyObject>, retweet: Int, favorite: Int) {
        
        self.tweetId = id
        self.tweetText = text
        self.user = user
        self.retweet_count = retweet
        self.favorite_count = favorite
        
    }
}



