//
//  TwitterAPI_Get.swift
//  Twitter
//
//  Created by 古川俊樹 on 2016/06/23.
//  Copyright © 2016年 Ryo. All rights reserved.
//

import UIKit
import Social
import Accounts

class TwitterAPI_Get {
    
    //Twitterにアクセスするためのkeyを定義
    let consumerKey = 	"j7pcQ8UodJk0PovXaW4TirsPi"
    let consumerSecret = "892GPCPfWLWRUuMYQYrxFb0fYTlDRXUAyLkhySeGevBYobHm49"
    let authURL = "https://api.twitter.com/oauth2/token"
    
    // MARK:- Bearer Token
    //Getting bearer Token to allow users to access Twitter.
    func getBearerToken(completion:(bearerToken: String) ->Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: authURL)!)
        
        request.HTTPMethod = "POST"
        request.addValue("Basic " + getBase64EncodeString(), forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        let grantType =  "grant_type=client_credentials"
        
        request.HTTPBody = grantType.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        NSURLSession.sharedSession() .dataTaskWithRequest(request, completionHandler: { (data: NSData?, response:NSURLResponse?, error: NSError?) -> Void in
            
            do {
                if let results: NSDictionary = try NSJSONSerialization .JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments  ) as? NSDictionary {
                    if let token = results["access_token"] as? String {
                        completion(bearerToken: token)
                    } else {
                        print(results["errors"])
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }).resume()
        
    }
    
    // MARK:- base64Encode String
    func getBase64EncodeString() -> String {
        
        let consumerKeyRFC1738 = consumerKey.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())
        let consumerSecretRFC1738 = consumerSecret.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())
        
        let concatenateKeyAndSecret = consumerKeyRFC1738! + ":" + consumerSecretRFC1738!
        
        let secretAndKeyData = concatenateKeyAndSecret.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        
        let base64EncodeKeyAndSecret = secretAndKeyData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
        
        return base64EncodeKeyAndSecret!
    }
    
    
    func fetchUsersTimeline(account: ACAccount, completion:  ([TimeLine]->Void)!)  {
        
            let URL: NSURL = NSURL (string:"https://api.twitter.com/1.1/statuses/home_timeline.json?count=200" )!
        
            let request = SLRequest(forServiceType: SLServiceTypeTwitter,  requestMethod: .GET, URL: URL, parameters: nil)
            request.account = account
        
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
            request.performRequestWithHandler { (data, responce, error) -> Void in
                    if error != nil {
                        //エラーがあった場合
                        print(error?.localizedDescription)
                    } else {
                        //エラーがなかった場合
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                        var Timeine = [TimeLine]()
                
                        do {
                            if let timelineData = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSArray {
                        
                                for timeline in timelineData {
                                    let timeline = TimeLine(id: timeline["id"] as! Int, text: timeline["text"] as! String, user: timeline["user"] as! Dictionary<String, AnyObject>, retweet: timeline["retweet_count"] as! Int, favorite: timeline["favorite_count"] as! Int)
                                    Timeine.append(timeline)
                                    
                                }
                        
                            }
                    
                        } catch let error as NSError {
                            //エラーがあった場合
                            print(error.localizedDescription)
                        }
                
                        //非同期で処理
                        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                        dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                completion(Timeine)
                                
                                    })
                            })
                        
                    }
            
            }
    
        }
    
    
    func fetchTweets(username: String, completion: ([Tweet] -> Void)! ) {
        
            let url = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=%40\(username)&count=200&trim_user=false&exclude_replies=true&include_rts=true"
    
            getBearerToken {  (bearerToken) -> Void in
            
                let request = NSMutableURLRequest(URL: NSURL(string: url)!)
                     request.HTTPMethod = "GET"
            
                    let token = "Bearer " + bearerToken
                    request.addValue(token, forHTTPHeaderField: "Authorization")
            
                    let sesion = NSURLSession.sharedSession()
                    sesion.dataTaskWithRequest(request, completionHandler:  { (data, response, error) -> Void in
                        if error != nil  {
                            //エラーがある時
                            print(error?.localizedDescription)
                        }  else {
                            //エラーがない時
                            var tweets = [Tweet] ( )
                            
                            do{
                                
                                if let tweetData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray {
                                    
                                    for tweet in tweetData  {
                                        let tweet  = Tweet(text: tweet["text"] as! String, retweet: tweet["retweet_count"] as! Int, favorite: tweet["favorite_count"] as! Int, user: tweet["user"] as! Dictionary<String, AnyObject>)
                                        tweets.append(tweet)
                                    }
                                }
                                
                            } catch let error as NSError {
                                //jsonでエラーがある時
                                
                                print(error.localizedDescription)
                            }
                            
                            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                            dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    completion(tweets)
                                })
                            })
                        }
            }).resume()
        }
    }
    
}


