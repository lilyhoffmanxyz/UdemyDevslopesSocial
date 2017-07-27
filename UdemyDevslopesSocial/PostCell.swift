//
//  PostCell.swift
//  UdemyDevslopesSocial
//
//  Created by Lily Hofman on 7/15/17.
//  Copyright © 2017 Lily Hoffman. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    @IBOutlet var profileImg: CircleView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var likeImage: CircleView!
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var caption: UITextView!
    @IBOutlet var likesLabel: UILabel!
    
    var post: Post!
    
    
    func configureCell(post: Post, image: UIImage? = nil){
        self.post = post
        self.caption.text = post.caption
        self.likesLabel.text = "\(post.likes)"
        
        if image != nil{
            self.postImage.image = image
        }else{
            let ref = Storage.storage().reference(forURL: post.imageURL)
            ref.getData(maxSize: 2 * 1024 * 1024, completion: {(data, error) in
                if error != nil{
                    print("Error - unable to download image from firebase storage")
                }else{
                    //download images and save to cache
                    if let imageData = data{
                        if let img = UIImage(data: imageData){
                            self.postImage.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageURL as NSString)
                        }
                    }
                }
            
            })
            
        }
    }

}
