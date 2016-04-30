//
//  AppBoxWidget.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 24.04.16.
//  Copyright © 2016 Finn Gaida. All rights reserved.
//

import UIKit
import GradientView

class AppBoxWidget: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = frame.height / 20
        
        let gradientView = GradientView(frame: CGRectMake(0, 0, frame.width, frame.height))
        gradientView.colors = [UIColor(red: 229/255, green: 57/255, blue: 53/255, alpha: 1), UIColor(red: 255/255, green: 179/255, blue: 0/255, alpha: 1)]
        self.addSubview(gradientView)
        
        let confetti = SAConfettiView(frame: gradientView.frame)
        confetti.startConfetti()
        self.layer.addSublayer(confetti.layer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
