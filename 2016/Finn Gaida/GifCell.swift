//
//  GifCell.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 21.04.16.
//  Copyright © 2016 Finn Gaida. All rights reserved.
//

import UIKit
import PhotosUI

class GifCell: UIView, PHLivePhotoViewDelegate {
    
    var imageView:PHLivePhotoView?
    var container: UIView?
    var textLabel:UILabel?
    var button:UIButton?
    var delegate:MasterViewController?
    
    func initialize(index: Int) {
        
        let right = index % 2 != 0
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 10
        
        container = UIView(frame: CGRectMake(right ? dist : 0, 0, self.frame.width - dist, self.frame.width - dist))
        container?.layer.borderWidth = 2
        container?.layer.masksToBounds = true
        container?.layer.cornerRadius = self.frame.width / 10
        container?.layer.borderColor = UIColor.whiteColor().CGColor
        self.addSubview(container!)
        
        let connector = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        connector.frame = CGRectMake(right ? 0 : (container?.frame.width)! - (vibrancyWidth / 2), self.frame.height / 2 - (vibrancyWidth / 2), dist * 1.1, vibrancyWidth)
        connector.layer.masksToBounds = true
        connector.layer.cornerRadius = connector.frame.height / 2
        self.insertSubview(connector, belowSubview: container!)
        
        imageView = PHLivePhotoView(frame: CGRectMake(0, 0, self.frame.width - dist, self.frame.height - dist))
        imageView?.delegate = self
        imageView?.layer.masksToBounds = true
        imageView?.layer.cornerRadius = self.layer.cornerRadius
        container?.addSubview(imageView!)
        
        textLabel = UILabel(frame: CGRectMake(right ? dist : 0, self.frame.height - dist, self.frame.width - dist, dist))
        textLabel?.textAlignment = .Center
        textLabel?.textColor = .whiteColor()
        textLabel?.font = UIFont.systemFontOfSize(12)
        textLabel?.text = "Loading..."
        self.addSubview(textLabel!)
        
        button = UIButton(frame: CGRectMake(0, 0, self.frame.width, self.frame.height))
        button?.addTarget(self, action: #selector(GifCell.buttonPress), forControlEvents: .TouchUpInside)
        self.addSubview(button!)
        
        ImageSorcery.share.loadPhoto(index, size: imageView!.frame.size) { (photo) in
            
            if let p = photo {
                self.imageView?.livePhoto = p
                self.imageView?.startPlaybackWithStyle(.Full)
            } else {
                print("error photo unwrap")
            }
        }
    }
    
    func buttonPress() {
        self.delegate?.showDetail(self.tag)
    }
    
    func livePhotoView(livePhotoView: PHLivePhotoView, didEndPlaybackWithStyle playbackStyle: PHLivePhotoViewPlaybackStyle) {
        imageView?.startPlaybackWithStyle(.Full)
    }
    
    func livePhotoView(livePhotoView: PHLivePhotoView, willBeginPlaybackWithStyle playbackStyle: PHLivePhotoViewPlaybackStyle) {
        
    }

}
