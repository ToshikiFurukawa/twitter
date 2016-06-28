//
//  ProfileViewController.swift
//  Twitter
//
//  Created by 福田涼介 on 12/22/15.
//  Copyright © 2015 Ryo. All rights reserved.
//

import UIKit
import Social
import Accounts

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var banner_imageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screen_nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var numberOfFollowing: UILabel!
    
    @IBOutlet weak var switchSegment: UISegmentedControl!
    
    var api = TwitterAPI_Get()
    var tweets = [Tweet]( )
    
    var account:  ACAccount!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let timelineNib = UINib(nibName: "MyTimelineTableViewCell", bundle: nil)
        tableView.registerNib(timelineNib, forCellReuseIdentifier: Cell.cellIdentifier)
        
        api.fetchTweets(account.username, completion: didLoadTweets)
        
        profileImageView.layer.cornerRadius = 4
        profileImageView.clipsToBounds = true
        
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        closeButton.layer.cornerRadius = 4
        closeButton.clipsToBounds = true
        
        closeButton.layer.borderWidth = 2
        closeButton.layer.borderColor = UIColor(red: 85/255, green: 172/255, blue: 238/255, alpha: 1).CGColor
    }
    
    func didLoadTweets(tweets:  [Tweet])  {
        self.tweets = tweets
        tableView.reloadData()
        
        showUserInfo()
    }

    func showUserInfo () {
        
        let user = tweets[0].user
        
        Helper.AsyncLoadProfileImage(user["profile_background_image_url"] as! String, imageView:  banner_imageView)
        Helper.AsyncLoadProfileImage(user["profile_image_url"] as! String, imageView:  profileImageView)
        
        self.usernameLabel.text = user["name"] as? String
        self.screen_nameLabel.text = user["screen_name"] as? String
        self.descriptionLabel.text = user["description"] as? String
        
        self.numberOfFollowing.text = "\(user["friends_count"] as! Int)  FOLLOWINGS  \( user["followers_count"] as! Int ) FOLLOWEES "
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    struct Cell {
        static let cellIdentifier = "My Timeline Cell"
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Cell.cellIdentifier, forIndexPath: indexPath) as! MyTimelineTableViewCell
        
        cell.tweet  = tweets[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
}