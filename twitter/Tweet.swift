//
//  Tweet.swift
//  Twitter
//
//  Created by 古川俊樹 on 2016/06/24.
//  Copyright © 2016年 Ryo. All rights reserved.
//

import UIKit

class Tweet {
    
    var tweetText: String!
    var retweet_count: Int!
    var favorite_count: Int!
    var user: Dictionary<String,  AnyObject>!
    var imageData: NSData?
    
    init(text: String, retweet: Int, favorite: Int, user: Dictionary<String, AnyObject> ) {
        
        self.tweetText = text
        self.retweet_count = retweet
        self.favorite_count = favorite
        self.user = user
    }
}
