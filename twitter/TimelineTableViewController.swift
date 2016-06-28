//
//  TimelineTableViewController.swift
//  Twitter
//
//  Created by 福田涼介 on 12/22/15.
//  Copyright © 2015 Ryo. All rights reserved.
//

import UIKit
import Accounts

class TimelineTableViewController: UITableViewController {
    
    var loggedInAccount = ACAccount()
    var api = TwitterAPI_Get()
    
    var timeline = [TimeLine]()
    
    @IBOutlet weak var tweetButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavigationBar settings
        navigationController?.navigationBar.barTintColor = UIColor(red: 85/255, green: 172/255, blue: 238/255, alpha: 1)
        navigationController?.navigationBar.barStyle = .Black
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        title = "Timeline"
        self.navigationItem.rightBarButtonItem = tweetButton
        
        //tableVeiwをコンテンツのサイズに合わせて調節する。
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension

        print(loggedInAccount.username)
        //セルのXIBをtableVeiewにレジスター
        let timelineNib = UINib(nibName: "TimelineTableViewCell", bundle: nil)
        tableView.registerNib(timelineNib, forCellReuseIdentifier: Cell.cellIdentifier)
        
        api.fetchUsersTimeline(loggedInAccount, completion: didLoadTimeline)
    }
    
    func didLoadTimeline(timeline:  [TimeLine] ) {
   
        self.timeline = timeline
        tableView.reloadData()

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func ComposeButton_Clicked(sender: AnyObject) {
        
        self.performSegueWithIdentifier("Show Tweet Screen", sender: self)
    }
    
    @IBAction func showProfileButton_Clicked(sender: AnyObject) {
        
        self.performSegueWithIdentifier("Show Profile", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Show Profile" {
            let destVC = segue.destinationViewController as! ProfileViewController
            destVC.account = loggedInAccount
       }
    }
    

    
    // MARK: - Table view data source
    
    struct Cell {
        static let cellIdentifier = "TimeLine Cell"
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return timeline.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Cell.cellIdentifier, forIndexPath: indexPath) as! TimelineTableViewCell

        cell.timeline = timeline[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }


}
