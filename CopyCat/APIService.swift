//
//  APIService.swift
//  CopyCat
//
//  Created by YAN DONG LIU on 09/10/2016.
//  Copyright © 2016 YAN DONG LIU. All rights reserved.
//

import UIKit

class APIService: NSObject {
    
    var videos: [Video]?
    
    static let sharedInstance = APIService()
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        
        // let url = URL(string: "https://raw.githubusercontent.com/liuyandong/youtube/master/home.json")
        let url = URL(string: "http://192.168.1.239/copy_youtube/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    video.numberOfViews = dictionary["number_of_views"] as? NSNumber
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    video.channel = channel
                    
                    videos.append(video)
                }
                
                DispatchQueue.main.async {
                    completion(videos)
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
        
    }
    
}
