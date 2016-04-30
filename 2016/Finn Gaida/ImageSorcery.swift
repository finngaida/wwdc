//
//  ImageSorcery.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 21.04.16.
//  Copyright © 2016 Finn Gaida. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import PhotosUI

class ImageSorcery: NSObject {
    
    static let share = ImageSorcery()
    var savedMovs:Int = 0
    var saving:Bool = false
    
    let videoNames = (0...10).map { "vid\($0)" }       // .m4v
    
    func loadVideosToDisk() {
        
        let _ = try? NSFileManager.defaultManager().createDirectoryAtPath(FilePaths.VidToLive.livePath as! String, withIntermediateDirectories: true, attributes: nil)
        
        for (i, name) in videoNames.enumerate() {
            
            let assetIdentifier = NSUUID().UUIDString
            let videoURL = NSBundle.mainBundle().URLForResource(name, withExtension: "mp4")!
            QuickTimeMov(path: videoURL.path!).write(FilePaths.VidToLive.livePath.stringByAppendingString("/IMG\(i).MOV"), assetIdentifier: assetIdentifier)
            
            if !saving {
                saving = true
                if let image = UIImage(named: "vid\(i).png"), data = UIImagePNGRepresentation(image) {
                    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
                    let imageURL = urls[0].URLByAppendingPathComponent("image\(i).jpg")
                    data.writeToURL(imageURL, atomically: true)
                    
                    JPEG(path: imageURL.path!).write(FilePaths.VidToLive.livePath.stringByAppendingString("/IMG\(i).JPG"), assetIdentifier: assetIdentifier)
                    self.saving = false
                }
            }
        }
    }
    
    func loadPhoto(index: Int, size: CGSize, response: (PHLivePhoto? -> ())) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
        PHLivePhoto.requestLivePhotoWithResourceFileURLs([ NSURL(fileURLWithPath: FilePaths.VidToLive.livePath.stringByAppendingString("/IMG\(index).MOV")), NSURL(fileURLWithPath: FilePaths.VidToLive.livePath.stringByAppendingString("/IMG\(index).JPG"))], placeholderImage: UIImage(named: "vid\(index).png"), targetSize: size, contentMode: PHImageContentMode.AspectFit, resultHandler: { (livePhoto, info) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), {
                response(livePhoto)
            })
            
        })
        }
    }
    
}