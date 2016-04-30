//
//  KeyboardWidget.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 25.04.16.
//  Copyright © 2016 Finn Gaida. All rights reserved.
//

import UIKit

class KeyboardWidget: UIView {

    var keyboard: KeyboardViewController?
    var textField:UITextField?
    var vc: UIViewController?
    var mode:Bool = true
    
    init(frame: CGRect, vc: UIViewController) {
        super.init(frame: frame)
        self.vc = vc
        self.layer.masksToBounds = true
        self.layer.cornerRadius = frame.height / 20
        self.backgroundColor = UIColor(red: 0.824, green: 0.835, blue: 0.859, alpha: 1.00)
        
        keyboard = KeyboardViewController(nibName: nil, bundle: nil, emoji: false)
        keyboard?.view.frame = CGRectMake(0, 0, frame.width, frame.height - frame.height * 0.15 - 20)
        vc.addChildViewController(keyboard!)
        self.addSubview(keyboard!.view)
        
        textField = UITextField(frame: CGRectMake(10, 5, frame.width, frame.height / 10))
        keyboard?.textField = textField!
        keyboard?.view.addSubview(textField!)
        
        let switchLabel = UILabel(frame: CGRectMake(20, keyboard!.view.frame.height + 10, frame.width - 40, frame.height * 0.15))
        switchLabel.textAlignment = .Center
        switchLabel.text = "A                   🐶"
        self.addSubview(switchLabel)
        
        let cSwitch = UISwitch()
        cSwitch.center = switchLabel.center
        cSwitch.addTarget(self, action: #selector(KeyboardWidget.switchKeyboard(_:)), forControlEvents: .ValueChanged)
        self.addSubview(cSwitch)
    }
    
    func switchKeyboard(sender:UISwitch) {
//        mode = sender.on
//        keyboard?.defaultsChanged(mode)
        keyboard = KeyboardViewController(nibName: nil, bundle: nil, emoji: sender.on)
        keyboard?.view.frame = CGRectMake(0, 0, frame.width, frame.height - self.frame.height * 0.15 - 20)
        vc?.addChildViewController(keyboard!)
        keyboard?.textField = textField!
        keyboard?.view.addSubview(textField!)
        self.addSubview(keyboard!.view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
