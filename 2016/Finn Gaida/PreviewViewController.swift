//
//  PreviewViewController.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 21.04.16.
//  Copyright © 2016 Finn Gaida. All rights reserved.
//

import UIKit
import PhotosUI

class PreviewViewController: UIViewController {
    
    var liveView: PHLivePhotoView?
    var image:PHLivePhoto? {
        didSet {
            self.liveView?.livePhoto = image
            self.liveView?.startPlaybackWithStyle(.Full)
        }
    }
    
    var imageView: UIImageView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.liveView = PHLivePhotoView(frame: self.view.frame)
//        self.view.addSubview(liveView!)
//        liveView?.backgroundColor = .redColor()
        
        self.imageView = UIImageView(frame: self.view.frame)
        self.view.addSubview(imageView!)
    }
    
}

