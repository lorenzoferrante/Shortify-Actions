//
//  String+Extension.swift
//  Shortify Actions
//
//  Created by Lorenzo Ferrante on 11/13/20.
//

import Foundation

extension String {
    static let blueTop = "#367BE2"
    static let blueBottom = "#0245BA"
    
    static let redTop = "#FF304C"
    static let redBottom = "#C40224"
    
    static let yellowTop = "#F1BD00"
    static let yellowBottom = "#E68500"
    
    static let greenTop = "#66D146"
    static let greenBottom = "#369B0D"
    
    static let orangeTop = "#FC861B"
    static let orangeBottom = "#E45B00"
    
    static let aquaGreenTop = "#3BCDAE"
    static let aquaGreenBottom = "#00A490"
    
    static let lightBlueTop = "#53A9F2"
    static let lightBlueBottom = "#0777E0"
    
    static let purpleTop = "#7F5BDF"
    static let purpleBottom = "#4C21BA"
    
    static let pinkTop = "#F069AE"
    static let pinkBottom = "#CC2D7C"
    
    static let metalTop = "#909BB0"
    static let metalBottom = "#6C748D"
    
    static let addBlue = "#056DFC"
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}

public let SFSymbolsList: [String] = [
    "square.and.arrow.up","square.and.arrow.up.fill","square.and.arrow.down","square.and.arrow.down.fill","square.and.arrow.up.on.square","square.and.arrow.up.on.square.fill","square.and.arrow.down.on.square"]

extension NSCharacterSet {
    var characters:[String] {
        var chars = [String]()
        for plane:UInt8 in 0...16 {
            if self.hasMemberInPlane(plane) {
                let p0 = UInt32(plane) << 16
                let p1 = (UInt32(plane) + 1) << 16
                for c:UTF32Char in p0..<p1 {
                    if self.longCharacterIsMember(c) {
                        var c1 = c.littleEndian
                        let s = NSString(bytes: &c1, length: 4, encoding: String.Encoding.utf32LittleEndian.rawValue)!
                        chars.append(String(s))
                    }
                }
            }
        }
        return chars
    }
}
