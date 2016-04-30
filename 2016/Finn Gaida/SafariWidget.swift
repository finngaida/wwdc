//
//  SafariWidget.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 28.04.16.
//  Copyright © 2016 Finn Gaida. All rights reserved.
//

import UIKit
import SafariServices

class SafariWidget: UIView, SFSafariViewControllerDelegate {
    
    var vc: UIViewController?
    var url: NSURL?

    init(frame: CGRect, url: NSURL, vc: UIViewController) {
        super.init(frame: frame)
        self.vc = vc
        self.url = url
        
        let host = url.host ?? "Safari"
        self.layer.masksToBounds = true
        self.layer.cornerRadius = frame.height / 10
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 2
        
        let safari = UIImageView(frame: CGRectMake(frame.height * 0.1, frame.height * 0.2, frame.height * 0.6, frame.height * 0.6))
        safari.image = UIImage(named: "safari")
        self.addSubview(safari)
        
        let label = UILabel(frame: CGRectMake(frame.height * 0.8, frame.height * 0.1, frame.width - frame.height * 0.8, frame.height * 0.8))
        label.font = UIFont.systemFontOfSize(25)
        label.text = "Show on \(host)"
        label.numberOfLines = 0
        self.addSubview(label)
        
        let button = UIButton(frame: CGRectMake(0, 0, frame.width, frame.height))
        button.addTarget(self, action: #selector(SafariWidget.show), forControlEvents: .TouchUpInside)
        self.addSubview(button)
    }
    
    func show() {
        let safari = SFSafariViewController(URL: url!, entersReaderIfAvailable: false)
        safari.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        safari.delegate = self
        vc?.presentViewController(safari, animated: true, completion: nil)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
