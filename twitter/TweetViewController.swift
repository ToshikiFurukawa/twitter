//
//  TweetViewController.swift
//  Twitter
//
//  Created by 福田涼介 on 12/31/15.
//  Copyright © 2015 Ryo. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton_Clicked(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    @IBAction func tweetButton_Clicked(sender: AnyObject) {
        print("tweetButton_Clicked")
    }
    

}
