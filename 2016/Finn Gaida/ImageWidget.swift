//
//  ImageWidget.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 27.04.16.
//  Copyright © 2016 Finn Gaida. All rights reserved.
//

import UIKit
import JTSImageViewController

class ImageWidget: UIView {

    var parent: UIViewController?
    var images: [String] = []
    
    init(frame: CGRect, images: [String], parent: UIViewController) {
        super.init(frame: frame)
        self.images = images
        self.parent = parent
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = frame.height / 10
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 2
        self.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        
        let width = frame.height * 0.8
        for (i, img) in images.enumerate() {
            let btn = UIButton(frame: CGRectMake(frame.height * 0.1 + (frame.height * 0.1 + width) * CGFloat(i), frame.height * 0.1, width, width))
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = frame.height / 10
            btn.tag = i
            btn.setImage(UIImage(named: img), forState: .Normal)
            btn.addTarget(self, action: #selector(ImageWidget.show(_:)), forControlEvents: .TouchUpInside)
            self.addSubview(btn)
        }
    }
    
    func show(sender: UIButton) {
        let imageInfo = JTSImageInfo()
        imageInfo.image = UIImage(named: self.images[sender.tag])
        imageInfo.referenceRect = self.frame
        imageInfo.referenceView = self.superview
        
        // Setup view controller
        let imageViewer = JTSImageViewController(imageInfo: imageInfo, mode: JTSImageViewControllerMode.Image, backgroundStyle: JTSImageViewControllerBackgroundOptions.Scaled)
        
        // Present the view controller.
        imageViewer.showFromViewController(parent, transition:JTSImageViewControllerTransition.FromOriginalPosition)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
