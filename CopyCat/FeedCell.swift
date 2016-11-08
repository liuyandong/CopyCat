//
//  FeedCell.swift
//  CopyCat
//
//  Created by YAN DONG LIU on 14/10/2016.
//  Copyright © 2016 YAN DONG LIU. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var videos: [Video]?
    let cellId = "cellId"
    
    func fetchVideos() {
        APIService.sharedInstance.fetchVideos { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout:layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
        
    }()
    
    override func setUpViews() {
        super.setUpViews()
        
        fetchVideos()
        
        addSubview(collectionView)
        addConstraintsWithVisualFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithVisualFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(YouTubeVideoCell.self, forCellWithReuseIdentifier: cellId)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! YouTubeVideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9/16
        return CGSize(width: frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let svp = VideoLauncher()
        svp.showVideoPlayer()
    }

}
