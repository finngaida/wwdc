//
//  AppStoreWidget.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 26.04.16.
//  Copyright © 2016 Finn Gaida. All rights reserved.
//

import UIKit
import StoreKit

class AppStoreWidget: UIView, SKStoreProductViewControllerDelegate {
    
    var icon: UIImageView?
    var title: UILabel?
    var developer: UILabel?
    var rating: UILabel?
    var store: UIButton?
    var index:Int = 0
    
    let titles = ["Custom Keys Keyboard", "Opera Mediaworks D-A-CH", "Just Brightness", "FabTap", "SunUp"]
    let devs = ["Finn Gaida", "apprupt GmbH", "Finn Gaida", "Finn Gaida", "Finn Gaida"]
    let ratings = [5, 4, 4, 3, 4]
    let ids = ["1104673201", "649762949", "784533845", "861902190", "648312177"]
    
    init(frame: CGRect, index: Int) {
        super.init(frame: frame)
        
        let margin:CGFloat = frame.height / 10
        self.layer.masksToBounds = true
        self.layer.cornerRadius = margin
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 2
        self.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        self.index = index
        
        icon = UIImageView(frame: CGRectMake(margin, margin, frame.height - (margin * 2), frame.height - (margin * 2)))
        icon?.layer.masksToBounds = true
        icon?.layer.cornerRadius = margin * 2
        icon?.image = UIImage(named: "icon\(index).png")
        self.addSubview(icon!)
        
        title = UILabel(frame: CGRectMake(icon!.frame.width + margin * 2, frame.height * 0.2, frame.width - icon!.frame.width - margin * 4, margin * 2))
        title?.font = UIFont.systemFontOfSize(20)
        title?.text = titles[index]
        self.addSubview(title!)
        
        developer = UILabel(frame: CGRectMake(icon!.frame.width + margin * 2, frame.height * 0.4, frame.width - icon!.frame.width - margin * 4, margin * 2))
        developer?.font = UIFont.systemFontOfSize(13)
        developer?.textColor = UIColor.grayColor()
        developer?.text = devs[index]
        self.addSubview(developer!)
        
        rating = UILabel(frame: CGRectMake(icon!.frame.width + margin * 2, frame.height * 0.65, frame.width - icon!.frame.width - margin * 4, margin * 2))
        rating?.font = UIFont.systemFontOfSize(15)
        rating?.textColor = UIColor.lightGrayColor()
        let ratingText = NSMutableAttributedString(string: "★★★★★")
        ratingText.addAttributes([NSForegroundColorAttributeName:UIColor.yellowColor()], range: NSMakeRange(0, ratings[index]))
        rating?.attributedText = ratingText
        self.addSubview(rating!)
        
        store = UIButton(frame: CGRectMake(frame.width * 0.75, frame.height * 0.5, frame.width * 0.2, frame.height * 0.35))
        store?.layer.masksToBounds = true
        store?.layer.cornerRadius = store!.frame.height / 5
        store?.layer.borderColor = UIColor(red: 0.000, green: 0.478, blue: 1.000, alpha: 1.00).CGColor
        store?.layer.borderWidth = 2
        store?.addTarget(self, action: #selector(AppStoreWidget.show), forControlEvents: .TouchUpInside)
        let btitle = UILabel(frame: CGRectMake(0, 0, store!.frame.width, store!.frame.height))
        btitle.font = UIFont.systemFontOfSize(17)
        btitle.textColor = UIColor(red: 0.000, green: 0.478, blue: 1.000, alpha: 1.00)
        btitle.text = "SHOW"
        btitle.textAlignment = .Center
        store?.addSubview(btitle)
        self.addSubview(store!)
    }
    
    func show() {
        // go to appstore
        let appstore = SKStoreProductViewController()
        appstore.delegate = self
        UIApplication.sharedApplication().keyWindow?.rootViewController!.presentViewController(appstore, animated: true, completion: { () -> Void in
            appstore.loadProductWithParameters([SKStoreProductParameterITunesItemIdentifier:self.ids[self.index]], completionBlock: { (result, error) -> Void in
                
                if error != nil {
                    print("error showing appstore with \(self.ids[self.index])")
                    appstore.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
                }
            })
        })
    }
    
    func productViewControllerDidFinish(viewController: SKStoreProductViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
