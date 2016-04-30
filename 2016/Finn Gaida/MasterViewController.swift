//
//  MasterViewController.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 21.04.16.
//  Copyright © 2016 Finn Gaida. All rights reserved.
//

import UIKit
import PeekPop
import PhotosUI
import PassKit

let dist:CGFloat = 20
let vibrancyWidth:CGFloat = 7

class MasterViewController: UIViewController, UIScrollViewDelegate, PeekPopPreviewingDelegate, PKAddPassesViewControllerDelegate {
    
    
    @IBOutlet weak var bg: UIView!
    var blur: UIVisualEffectView?
    @IBOutlet weak var scrollView: UIScrollView!
    var detailViewController: DetailViewController? = nil
    var peek:PeekPop?
    var cellSize:CGSize = CGSizeZero
    var insets:UIEdgeInsets = UIEdgeInsetsZero
    var cells:[GifCell] = []
    
    var objects = ["Custom Keyboard", "First Client", "WWDC 2015", "Opera", "School", "Side projects", "SunUp", "Hackathons", "First App", "Jailbreaking", "Youth"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profile = UIBarButtonItem(image: UIImage(named: "profile"), style: .Plain, target: self, action: #selector(MasterViewController.showProfile))
        self.navigationItem.leftBarButtonItem = profile
        
        let map = UIBarButtonItem(image: UIImage(named: "map"), style: .Plain, target: self, action: #selector(MasterViewController.showMap))
        self.navigationItem.rightBarButtonItem = map
        
        self.scrollView.backgroundColor = UIColor.clearColor()
        peek = PeekPop(viewController: self)
        
        // bg
        let img = UIImageView(frame: self.bg.frame)
        img.image = UIImage(named: "bg")
        self.bg.addSubview(img)
        
        blur = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        blur?.frame = self.bg.frame
        self.bg.addSubview(blur!)
        
        layoutViews()
        
    }
    
    func layoutViews() {
        
        let minimum = min(self.view.frame.width, self.view.frame.height)
        cellSize = CGSizeMake(minimum / 2.5, minimum / 2.5)
        insets = UIEdgeInsetsMake(minimum * 0.1, minimum * 0.1, minimum * 0.1, minimum * 0.1)
        let contentHeight:CGFloat = (cellSize.height - insets.top) * CGFloat(objects.count) + insets.top * 2 + insets.bottom
        self.scrollView.contentSize = CGSizeMake(self.view.frame.width, contentHeight)
        
        let vibrancy = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: self.blur?.effect as! UIBlurEffect))
        vibrancy.frame = CGRectMake(0, -(insets.top * 2), self.view.frame.width, contentHeight + cellSize.height + insets.bottom)
        let line = UIView(frame: CGRectMake(self.view.frame.width / 2 - (vibrancyWidth / 2), insets.top, vibrancyWidth, contentHeight - (insets.top * 2)))
        line.layer.masksToBounds = true
        line.layer.cornerRadius = line.frame.width / 2
        line.backgroundColor = UIColor.whiteColor()
        vibrancy.contentView.addSubview(line)
        
        let dot = UIView(frame: CGRectMake(line.frame.origin.x - vibrancyWidth / 2, line.frame.origin.y - vibrancyWidth / 2, vibrancyWidth * 2, vibrancyWidth * 2))
        dot.layer.masksToBounds = true
        dot.layer.cornerRadius = dot.frame.height / 2
        dot.backgroundColor = .whiteColor()
        vibrancy.contentView.addSubview(dot)
        self.scrollView.addSubview(vibrancy)
        
        let explanation = UILabel(frame: CGRectMake(10, 0, self.view.frame.width - 20, 30))
        let forceTouch = (UIDevice.currentDevice().localizedModel.containsString("6s")) ? "3D Touch" : "Long press"
        explanation.text = forceTouch + " the entries to see a preview"
        explanation.textAlignment = .Center
        vibrancy.contentView.addSubview(explanation)
        
        for (i, title) in objects.enumerate() {
            
            let odd = i % 2 == 0
            let x = (self.view.frame.width / 2) + (odd ? (-(cellSize.width)) : 0)
            
            let rect = CGRectMake(x, max((cellSize.height - insets.top), insets.top) * CGFloat(i) + insets.top, cellSize.width, cellSize.height)
            let cell = GifCell(frame: rect)
            cell.initialize(i)
            cell.textLabel?.text = title
            cell.tag = i
            cell.delegate = self
            
            peek?.registerForPreviewingWithDelegate(self, sourceView: cell)
            cells.append(cell)
            self.scrollView.addSubview(cell)
        }
        
    }
    
    func showMap() {
        self.performSegueWithIdentifier("showMap", sender: self)
    }
    
    func showProfile() {
        if (PKPassLibrary.isPassLibraryAvailable()) {
            var error: NSError?
            let pass = PKPass(data: NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("Finn", withExtension: "pkpass")!)!, error: &error)
            let vc = PKAddPassesViewController(pass: pass)
            vc.delegate = self
            self.presentViewController(vc, animated: true, completion: { 
                UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
            })
        }
    }
    
    func showDetail(index: Int) {
        self.performSegueWithIdentifier("showDetail", sender: index)
    }
    
    func addPassesViewControllerDidFinish(controller: PKAddPassesViewController) {
        controller.dismissViewControllerAnimated(true) { 
            UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 150 {
            self.title = "2016"
            return
        } else if scrollView.contentOffset.y < 400 {
            self.title = "2015"
            return
        } else if scrollView.contentOffset.y < 700 {
            self.title = "2014"
            return
        } else if scrollView.contentOffset.y < 1000 {
            self.title = "2013"
            return
        } else if scrollView.contentOffset.y > 1000 {
            self.title = "2011"
            return
        }
        
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        self.scrollView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        layoutViews()
    }
    
    func showIntro() {
        self.performSegueWithIdentifier("showIntro", sender: self)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
        
        if !NSUserDefaults.standardUserDefaults().boolForKey("appLaunched") {
            showIntro()
            ImageSorcery.share.loadVideosToDisk()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "appLaunched")
        }
        
        self.cells.forEach { (cell) in
            if let view = cell.imageView {
                if view.livePhoto != nil {
                    view.startPlaybackWithStyle(.Full)
                }
            }
        }
    }
    
    // MARK: PeekPop Delegate
    
    func previewingContext(previewingContext: PreviewingContext, viewControllerForLocation location: CGPoint, tag: Int) -> UIViewController? {
        let previewViewController = self.storyboard?.instantiateViewControllerWithIdentifier("preview") as! PreviewViewController
        
        let cell = cells[tag]
        previewViewController.title = objects[tag]
        previewingContext.sourceRect = CGRectMake((tag % 2 == 0) ? 0 : dist, 0, cell.frame.width - dist, cell.frame.width - dist)
        previewViewController.view.tag = tag
        previewViewController.imageView?.image = UIImage(named: "vid\(tag).png")
        
//        if let view = cell.imageView {
//            previewViewController.image = view.livePhoto
//        }
        
        return previewViewController
    }
    
    func previewingContext(previewingContext: PreviewingContext, commitViewController viewControllerToCommit: UIViewController) {
        self.performSegueWithIdentifier("showDetail", sender: viewControllerToCommit.view.tag)
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let index = sender as? Int {
                let title = objects[index]
                let controller = segue.destinationViewController as! DetailViewController
                controller.title = title
                controller.index = index
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if segue.identifier == "showIntro" {
            (segue.destinationViewController as! IntroViewController).delegate = self
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
