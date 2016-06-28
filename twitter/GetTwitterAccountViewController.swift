//
//  GetTwitterAccountViewController.swift
//  Twitter
//
//  Created by 福田涼介 on 12/22/15.
//  Copyright © 2015 Ryo. All rights reserved.
//

import UIKit
import Accounts
import Social

class GetTwitterAccountViewController: UIViewController {
    
    var accountStore = ACAccountStore()
    var twAccount = ACAccount()
    var accounts = [ACAccount]()
    

    override func viewDidLoad() {
            super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        
    }
    
    private func getAccountsFromDevice()  {
        
            let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
            accountStore.requestAccessToAccountsWithType(accountType, options: nil)  {  (success, error) -> Void in
                    if error != nil {
                            print(error?.localizedDescription)
                    }  else  {
                            if !success  {
                                print("not athorized")
                                return
                            }  else  {
                                    //リクエストが成功した時
                                    self.accounts = self.accountStore.accountsWithAccountType(accountType) as! [ACAccount]
                                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                        //アカウントを取得した後の処理
                                        self.showAndSelectTwitterAcount()
                                    
                                    })
                            }
                    }
            }
    }
    
    private func showAndSelectTwitterAcount() {
        
        let alertController = UIAlertController(title: "Select Account", message: "Please select a Twitter Acount", preferredStyle: .ActionSheet)
        if accounts.count == 0 {
            
            let noAccountAlert = UIAlertController(title: "No Account", message: "Please add twitter account from Setting", preferredStyle: .Alert)
            noAccountAlert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
            self.presentViewController(noAccountAlert,  animated: true, completion: nil)
            
        }  else  {
            
            for account in accounts {
                alertController.addAction(UIAlertAction(title: account.username, style: .Default, handler: { (ACTION) -> Void in
                    self.twAccount = account
                    self.performSegueWithIdentifier("Show Timeline", sender: self)
                    
                }))
            }
            
            //キャンセルボタンの追加
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:  AnyObject?) {
        if segue.identifier == "Show Timeline" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let destVC =  navigationController.topViewController as! TimelineTableViewController
            
            destVC.loggedInAccount = twAccount
        }
    }
    
    @IBAction func logo_Clicked(sender: AnyObject) {
        
        self .getAccountsFromDevice()
    }


}













