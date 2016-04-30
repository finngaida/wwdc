//
//  DefaultKeyboard.swift
//  TransliteratingKeyboard
//
//  Created by Alexei Baboulevitch on 7/10/14.
//  Copyright (c) 2014 Alexei Baboulevitch ("Archagon"). All rights reserved.
//

import Foundation
import UIKit

// MARK: Constants
let kEyboardUpdatedNotification = "newKeyboardNotification"
let kEyboardNumberOfPagesKey = "numofpages"
let defaults = NSUserDefaults(suiteName: "group.finngaida.keyboard")
let isPad = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad

// MARK: Helper Enums and functions
enum RowLocation:Int {
    case Top, Middle, Bottom, Spacebar
}

func numberOfKeysInRow(row: RowLocation, page: Int) -> Int {
    switch row {
    case .Top: return 10
    case .Middle: return page == 0 ? 9 : 10
    case .Bottom: return 9
    case .Spacebar: return 5
    }
}

func kEyboardRowKey(loc: RowLocation, page: Int) -> String {
    let matcher:[RowLocation:String] = [.Top:"topRow", .Middle:"middleRow", .Bottom:"bottomRow", .Spacebar:"spacebarRow"]
    return "\(matcher[loc])\(page)"
}

func kEyboardPageKey(page: Int) -> String {
    return "page\(page)"
}

func keyCapForPage(page: Int) -> String {
    let page = pageAtIndex(page)
    let cap = page[0..<3].map({$0.uppercaseKeyCap ?? ""}).reduce("", combine: +)
    return cap
}

func pageAtIndex(i: Int) -> [Key] {
    
    var page:[Key]?
    if let data = defaults?.objectForKey(kEyboardPageKey(i)) as? NSData {
        page = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Array<Key>
    } else {
        if i == 1 {
            let arr = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                       "-", "/", ":", ";", "(", ")", "$", "&", "@", "\"",
                       ".", ",", "?", "!", "'"]
            
            let hardpage = arr.map({ (s) -> Key in
                let k = Key(.Character)
                k.setLetter(s)
                return k
            })
            page = hardpage
            defaults?.setObject(NSKeyedArchiver.archivedDataWithRootObject(hardpage), forKey: kEyboardPageKey(i))
        } else {
            let arr = ["[", "]", "{", "}", "#", "%", "^", "*", "+", "=",
                       "_", "\\", "|", "~", "<", ">", "€", "£", "¥", "•",
                       ".", ",", "?", "!", "'"]
            let hardpage = arr.map({ (s) -> Key in
                let k = Key(.Character)
                k.setLetter(s)
                return k
            })
            page = hardpage
            defaults?.setObject(NSKeyedArchiver.archivedDataWithRootObject(hardpage), forKey: kEyboardPageKey(i))
        }
    }
    return page!
}

func keyRangeBetween(row1: RowLocation, row2: RowLocation, page: Int, max: Int) -> Range<Int> {
    var start = 0
    (0..<row1.rawValue).forEach {start += numberOfKeysInRow(RowLocation(rawValue:$0)!, page: page)}
    
    if start > max {
        start = max
    }
    
    var end = 0
    (0..<row2.rawValue).forEach {end += numberOfKeysInRow(RowLocation(rawValue:$0)!, page: page)}
    
    if end > max {
        end = max
    }
    
    return start..<end
}


// MARK: Main function
func defaultKeyboard(chars: Bool, functionKeys: Bool) -> Keyboard {
    
    // init defaults
    let defaultKeyboard = Keyboard()
    
    // prevent crash
    NSKeyedUnarchiver.setClass(Key.classForKeyedUnarchiver(), forClassName: "Manager.Key")
    
    // Letters page
    var page1:[Key]?
//    if let data = defaults?.objectForKey(kEyboardPageKey(0)) as? NSData {
//        page1 = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Array<Key>
//    } else {
        let arr = chars ? ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
                   "A", "S", "D", "F", "G", "H", "J", "K", "L",
                   "Z", "X", "C", "V", "B", "N", "M"] :
            ["🐶", "🐱", "🐭", "🐹", "🐰", "🐻", "🐼", "🐨", "🐯", "🦁",
                "🐮", "🐷", "🐸", "🐙", "🐵", "🐔", "🐧", "🐦", "🐤",
                "🐺", "🐗", "🐴", "🦄", "🐝", "🐛", "🐌"]
        
        var page = arr.map({ (s) -> Key in
            let k = Key(.Character)
            k.setLetter(s)
            return k
        })
        
        if isPad {
            let map = [(",", "!"), (".", "?")].map { (tupil) -> Key in
                let key = Key(.SpecialCharacter)
                key.lowercaseKeyCap = tupil.0
                key.uppercaseKeyCap = tupil.1
                key.lowercaseOutput = tupil.0
                key.uppercaseOutput = tupil.1
                return key
            }
            page.appendContentsOf(map)
        }
        
        page1 = page
//        defaults?.setObject(NSKeyedArchiver.archivedDataWithRootObject(page), forKey: kEyboardPageKey(0))
//    }
    
    let topRow = page1![keyRangeBetween(.Top, row2: .Middle, page: 0, max: (page1?.count)!)]
    for key in topRow {
        defaultKeyboard.addKey(key, row: 0, page: 0)
    }
    
    let middleRow = page1![keyRangeBetween(.Middle, row2: .Bottom, page: 0, max: (page1?.count)!)]
    for key in middleRow {
        defaultKeyboard.addKey(key, row: 1, page: 0)
    }
    
    let shift = Key(.Shift)
    
    if functionKeys {
        defaultKeyboard.addKey(shift, row: 2, page: 0)
    }
    
    let range = keyRangeBetween(.Bottom, row2: .Spacebar, page: 0, max: (page1?.count)!)
    let bottomRow = page1![range]
    for key in bottomRow {
        defaultKeyboard.addKey(key, row: 2, page: 0)
    }
    
    if functionKeys && isPad {
        let rightShift = Key(.Shift)
        defaultKeyboard.addKey(rightShift, row: 2, page: 0)
    }
    
    let backspace = Key(.Backspace)
    
    let keyModeChangeNumbers = Key(.ModeChange)
    keyModeChangeNumbers.uppercaseKeyCap = "123"
    keyModeChangeNumbers.toMode = 1
    
    let keyboardChange = Key(.KeyboardChange)
    
    let settings = Key(.Settings)
    
    let space = Key(.Space)
    space.uppercaseKeyCap = "space"
    space.uppercaseOutput = " "
    space.lowercaseOutput = " "
    
    let returnKey = Key(.Return)
    returnKey.uppercaseKeyCap = "return"
    returnKey.uppercaseOutput = "\n"
    returnKey.lowercaseOutput = "\n"
    
    let keyboardHide = Key(.Hide)
    
    if functionKeys {
        defaultKeyboard.addKey(backspace, row: isPad ? 0 : 2, page: 0)
        [keyModeChangeNumbers, keyboardChange, settings, space].forEach {defaultKeyboard.addKey($0, row: 3, page: 0)}
        defaultKeyboard.addKey(returnKey, row: isPad ? 1 : 3, page: 0)
        
        if isPad {
            let keyModeChangeNumbersRight = Key(.ModeChange)
            keyModeChangeNumbersRight.uppercaseKeyCap = "123"
            keyModeChangeNumbersRight.toMode = 1
            [keyModeChangeNumbersRight, keyboardHide].forEach {defaultKeyboard.addKey($0, row: 3, page: 0)}
        }
    }
    
    var pages:Int = 3
    if let defaultPages = defaults?.objectForKey(kEyboardNumberOfPagesKey) as? Int {
        if defaultPages == 0 {
            pages = 3
            defaults?.setObject(pages, forKey: kEyboardNumberOfPagesKey)
        }
        pages = defaultPages
    } else {
        defaults?.setObject(pages, forKey: kEyboardNumberOfPagesKey)
    }
    
    for i in 1..<pages {
        
        let page = pageAtIndex(i)
        
        let topRow = page[keyRangeBetween(.Top, row2: .Middle, page: i, max: page.count)]
        for key in topRow {
            defaultKeyboard.addKey(key, row: 0, page: i)
        }
        
        let middleRow = page[keyRangeBetween(.Middle, row2: .Bottom, page: i, max: page.count)]
        for key in middleRow {
            defaultKeyboard.addKey(key, row: 1, page: i)
        }
        
        if functionKeys {
            let keyModeChangeSpecialCharacters = Key(.ModeChange)
            keyModeChangeSpecialCharacters.uppercaseKeyCap = keyCapForPage(i+1)
            keyModeChangeSpecialCharacters.toMode = (i == pages - 1) ? 1 : i+1
            defaultKeyboard.addKey(keyModeChangeSpecialCharacters, row: 2, page: i)
        }
        
        let bottomRow = page[keyRangeBetween(.Bottom, row2: .Spacebar, page: i, max: page.count)]
        for key in bottomRow {
            defaultKeyboard.addKey(key, row: 2, page: i)
        }
        
        // back to letters
        let keyModeChangeLetters = Key(.ModeChange)
        keyModeChangeLetters.uppercaseKeyCap = "ABC"
        keyModeChangeLetters.toMode = 0
        
        if functionKeys {
            defaultKeyboard.addKey(Key(backspace), row: 2, page: i)
            
            [Key(keyModeChangeLetters), Key(keyboardChange), Key(settings), Key(space), Key(returnKey)].forEach {
                defaultKeyboard.addKey($0, row: 3, page: i)
            }
        }
        
    }
    
    defaultKeyboard.name = "Default Keyboard"
    
    return defaultKeyboard
}
