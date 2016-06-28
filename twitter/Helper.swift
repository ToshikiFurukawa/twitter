//
//  Helper.swift
//  Twitter
//
//  Created by 古川俊樹 on 2016/06/23.
//  Copyright © 2016年 Ryo. All rights reserved.
//

import UIKit

class Helper {
    class  func  AsyncLoadProfileImage(url: String, imageView: UIImageView)  {
    
        let downloadQueue = dispatch_queue_create("can, Twitter,Profile, download", nil)
        
        dispatch_async(downloadQueue) { () -> Void in
            
            let data = NSData(contentsOfURL: NSURL(string: url)!)
            
            var image: UIImage?
            
            if data  != nil  {
                image = UIImage(data: data!)
            }
            // ここまでが非同期で行われる
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                imageView.image = image
            }
        
        }
    }
}
