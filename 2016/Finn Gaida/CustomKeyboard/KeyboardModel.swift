//
//  KeyboardModel.swift
//  TransliteratingKeyboard
//
//  Created by Alexei Baboulevitch on 7/10/14.
//  Copyright (c) 2014 Alexei Baboulevitch ("Archagon"). All rights reserved.
//

import Foundation

var counter = 0

enum ShiftState {
    case Disabled
    case Enabled
    case Locked
    
    func uppercase() -> Bool {
        switch self {
        case Disabled:
            return false
        case Enabled:
            return true
        case Locked:
            return true
        }
    }
}

class Keyboard {
    var name: String
    var pages: [Page]
    
    init() {
        self.name = ""
        self.pages = []
    }
    
    func addKey(key: Key, row: Int, page: Int) {
        if self.pages.count <= page {
            for _ in self.pages.count...page {
                self.pages.append(Page())
            }
        }
        
        self.pages[page].addKey(key, row: row)
    }
}

class Page {
    var rows: [[Key]]
    
    init() {
        self.rows = []
    }
    
    func addKey(key: Key, row: Int) {
        if self.rows.count <= row {
            for _ in self.rows.count...row {
                self.rows.append([])
            }
        }

        self.rows[row].append(key)
    }
}

class Key: NSObject, NSCoding {
    enum KeyType:Int {
        case Character
        case SpecialCharacter
        case Shift
        case Backspace
        case ModeChange
        case KeyboardChange
        case Period
        case Space
        case Return
        case Settings
        case Hide
        case Other
    }
    
    var type: KeyType
    var uppercaseKeyCap: String?
    var lowercaseKeyCap: String?
    var uppercaseOutput: String?
    var lowercaseOutput: String?
    var toMode: Int? //if the key is a mode button, this indicates which page it links to
    
    var isCharacter: Bool {
        get {
            switch self.type {
            case
            .Character,
            .SpecialCharacter,
            .Period:
                return true
            default:
                return false
            }
        }
    }
    
    var isSpecial: Bool {
        get {
            switch self.type {
            case .Shift:
                return true
            case .Backspace:
                return true
            case .ModeChange:
                return true
            case .KeyboardChange:
                return true
            case .Return:
                return true
            case .Settings:
                return true
            case .Hide:
                return true
            default:
                return false
            }
        }
    }
    
    var hasOutput: Bool {
        get {
            return (self.uppercaseOutput != nil) || (self.lowercaseOutput != nil)
        }
    }
    
    // TODO: this is kind of a hack
//    var hashValue: Int
    
    override var description: String {
        get {
            return "Key: [uppercase Cap: \(self.uppercaseKeyCap), lowercase Cap: \(self.lowercaseKeyCap), uppercase Output: \(self.uppercaseOutput), lowercase Output: \(self.lowercaseOutput), type: \(self.type)]"
        }
    }
    
    init(_ type: KeyType) {
        self.type = type
//        self.hashValue = counter
        counter += 1
    }
    
    convenience init(_ key: Key) {
        self.init(key.type)
        
        self.uppercaseKeyCap = key.uppercaseKeyCap
        self.lowercaseKeyCap = key.lowercaseKeyCap
        self.uppercaseOutput = key.uppercaseOutput
        self.lowercaseOutput = key.lowercaseOutput
        self.toMode = key.toMode
    }
    
    func setLetter(letter: String) {
        self.lowercaseOutput = (letter as NSString).lowercaseString
        self.uppercaseOutput = (letter as NSString).uppercaseString
        self.lowercaseKeyCap = self.lowercaseOutput
        self.uppercaseKeyCap = self.uppercaseOutput
    }
    
    func outputForCase(uppercase: Bool) -> String {
        if uppercase {
            if self.uppercaseOutput != nil {
                return self.uppercaseOutput ?? self.lowercaseOutput ?? "Q"
            }
            else if self.lowercaseOutput != nil {
                return self.lowercaseOutput ?? self.uppercaseOutput ?? "q"
            }
            else {
                return ""
            }
        }
        else {
            if let out = self.lowercaseOutput {
                return out
            }
            else if let out = self.uppercaseOutput {
                return out
            }
            else {
                return ""
            }
        }
    }
    
    func keyCapForCase(uppercase: Bool) -> String {
        if uppercase {
            if self.uppercaseKeyCap != nil {
                return self.uppercaseKeyCap!
            }
            else if self.lowercaseKeyCap != nil {
                return self.lowercaseKeyCap!
            }
            else {
                return ""
            }
        }
        else {
            if self.lowercaseKeyCap != nil {
                return self.lowercaseKeyCap!
            }
            else if self.uppercaseKeyCap != nil {
                return self.uppercaseKeyCap!
            }
            else {
                return ""
            }
        }
    }
    
    
    // MARK: NSCoding
    let kTypeKey = "type"
    let kUppercaseKeyCapKey = "upKeyCap"
    let kLowercaseKeyCapKey = "lowKeyCap"
    let kUppercaseOutputKey = "upOut"
    let kLowercaseOutputKey = "lowOut"
    let kToModeKey = "mode"
    let kIsCharacterKey = "char"
    let kIsSpecialKey = "special"
    
    required init?(coder aDecoder: NSCoder) {
        self.type = KeyType(rawValue: Int(aDecoder.decodeIntForKey(kTypeKey)))!
        self.uppercaseKeyCap = aDecoder.decodeObjectForKey(kUppercaseKeyCapKey) as? String
        self.lowercaseKeyCap = aDecoder.decodeObjectForKey(kLowercaseKeyCapKey) as? String
        self.uppercaseOutput = aDecoder.decodeObjectForKey(kUppercaseOutputKey) as? String
        self.lowercaseOutput = aDecoder.decodeObjectForKey(kLowercaseOutputKey) as? String
        self.toMode = Int(aDecoder.decodeIntForKey(kToModeKey))
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInt(Int32(self.type.rawValue), forKey: kTypeKey)
        aCoder.encodeObject(self.uppercaseKeyCap, forKey: kUppercaseKeyCapKey)
        aCoder.encodeObject(self.lowercaseKeyCap, forKey: kLowercaseKeyCapKey)
        aCoder.encodeObject(self.uppercaseOutput, forKey: kUppercaseOutputKey)
        aCoder.encodeObject(self.lowercaseOutput, forKey: kLowercaseOutputKey)
        aCoder.encodeBool(self.isCharacter, forKey: kIsCharacterKey)
        aCoder.encodeBool(self.isSpecial, forKey: kIsSpecialKey)
        
        if let mode = self.toMode {
            aCoder.encodeInt(Int32(mode), forKey: kToModeKey)
        }
    }
}

func ==(lhs: Key, rhs: Key) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
