//
//  VideoCell.swift
//  CopyCat
//
//  Created by YAN DONG LIU on 9/21/16.
//  Copyright © 2016 YAN DONG LIU. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    func setUpViews() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class YouTubeVideoCell: BaseCell {
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            setupProfileImage()
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                
                subtitleTextView.text = "\(channelName) • \(formatter.string(from: numberOfViews)!) views • 2 years ago"
            }
        }
    }
    
    func setupThumbnailImage() {
        if let thumbnailUrl = video?.thumbnailImageName {
            videoThumbnailView.loadImageUsingUrlString(urlString: thumbnailUrl)
        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            profileView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    
    let videoThumbnailView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.green
        imageView.image = UIImage(named:"myDaughter")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let profileView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.green
        imageView.image = UIImage(named: "myProfile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Westlife - You Raise Me Up"
        lable.numberOfLines = 2
        return lable
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = false
        textView.text = "westlife • 48,585 views"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.rgb(red: 160, green: 160, blue: 160)
        return textView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 160, green: 160, blue: 160)
        return view
    }()
    
    override func setUpViews() {
        addSubview(videoThumbnailView)
        addSubview(separatorView)
        addSubview(profileView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraintsWithVisualFormat(format: "H:|-15-[v0]-15-|", views: videoThumbnailView)
        addConstraintsWithVisualFormat(format: "V:|-10-[v0]-8-[v1(44)]-10-[v2(1)]|", views: videoThumbnailView, profileView, separatorView)
        addConstraintsWithVisualFormat(format: "H:|[v0]|", views: separatorView)
        addConstraintsWithVisualFormat(format: "H:|-15-[v0(44)]", views: profileView)
        
        addConstraint(NSLayoutConstraint(item:titleLabel, attribute: .top, relatedBy: .equal, toItem: videoThumbnailView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item:titleLabel, attribute: .left, relatedBy: .equal, toItem: profileView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item:titleLabel, attribute: .right, relatedBy: .equal, toItem: videoThumbnailView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item:titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        addConstraint(NSLayoutConstraint(item:subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item:subtitleTextView, attribute: .left, relatedBy: .equal, toItem: profileView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item:subtitleTextView, attribute: .right, relatedBy: .equal, toItem: videoThumbnailView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item:subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
    }
}
