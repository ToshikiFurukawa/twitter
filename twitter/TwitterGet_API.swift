//
//  TwitterGet_API.swift
//  Twitter
//
//  Created by 福田涼介 on 12/31/15.
//  Copyright © 2015 Ryo. All rights reserved.
//

import UIKit

class TwitterAPI_Get {
    
    //TwitterにアクセスするためのKey
    let consumerKey = ""
    let consumerSecret = ""
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

    
}
