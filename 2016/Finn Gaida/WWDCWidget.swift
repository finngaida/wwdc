//
//  WWDCWidget.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 27.04.16.
//  Copyright © 2016 Finn Gaida. All rights reserved.
//

import UIKit

class WWDCWidget: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = frame.height / 10
        
        let pan = PanoramaView(frame: CGRectMake(0, 0, frame.width, frame.height))
        pan.setImage(UIImage(named: "pan.jpg")!)
        self.addSubview(pan)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
