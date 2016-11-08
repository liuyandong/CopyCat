//
//  Video.swift
//  CopyCat
//
//  Created by YAN DONG LIU on 26/09/2016.
//  Copyright © 2016 YAN DONG LIU. All rights reserved.
//

import UIKit

class Video: NSObject {
    var title: String?
    var thumbnailImageName: String?
    var numberOfViews: NSNumber?
    var channel: Channel?
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
