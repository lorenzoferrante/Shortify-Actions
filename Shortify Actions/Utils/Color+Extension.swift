//
//  Color+Extension.swift
//  Shortify Actions
//
//  Created by Lorenzo Ferrante on 11/13/20.
//

import Foundation
import SwiftUI

public enum CustomColors: Int16, CaseIterable, Identifiable {
    public var id: Int16 { self.rawValue }
    case Blue, LightBlue, BlueNeil, Purple, Pink, Red, RedNeil, Orange, Yellow, Lemon, Green, GreenNeil, AquaGreen, Metal, MetalGreen, AlmostBlack, Noir, White
}

extension Color {
    static let blueTop = Color(hex: "#367BE2")
    static let blueBottom = Color(hex: "#0245BA")
    
    static let blueNeilTop = Color(hex: "#49C6FD")
    static let blueNeilBottom = Color(hex: "#1F95DD")
    
    static let lightBlueTop = Color(hex: "#53A9F2")
    static let lightBlueBottom = Color(hex: "#0777E0")
    
    static let redTop = Color(hex: "#FF304C")
    static let redBottom = Color(hex: "#C40224")
    
    static let redNeilTop = Color(hex: "#FC6564")
    static let redNeilBottom = Color(hex: "#DB4234")
    
    static let yellowTop = Color(hex: "#F1BD00")
    static let yellowBottom = Color(hex: "#E68500")
    
    static let lemonTop = Color(hex: "#F7DC7C")
    static let lemonBottom = Color(hex: "#D0A614")
    
    static let greenTop = Color(hex: "#66D146")
    static let greenBottom = Color(hex: "#369B0D")
    
    static let greenNeilTop = Color(hex: "#21CA99")
    static let greenNeilBottom = Color(hex: "#04AD87")
    
    static let orangeTop = Color(hex: "#FC861B")
    static let orangeBottom = Color(hex: "#E45B00")
    
    static let aquaGreenTop = Color(hex: "#3BCDAE")
    static let aquaGreenBottom = Color(hex: "#00A490")
    
    static let purpleTop = Color(hex: "#7F5BDF")
    static let purpleBottom = Color(hex: "#4C21BA")
    
    static let pinkTop = Color(hex: "#F069AE")
    static let pinkBottom = Color(hex: "#CC2D7C")
    
    static let metalTop = Color(hex: "#909BB0")
    static let metalBottom = Color(hex: "#6C748D")
    
    static let metalGreenTop = Color(hex: "#344245")
    static let metalGreenBottom = Color(hex: "#071A26")
    
    static let noir = Color(hex: "#000")
    
    static let white = Color(hex: "#fff")
    
    static let almostBlackTop = Color(hex: "#222222")
    static let almostBlackBottom = Color(hex: "#090909")
    
    static let addCellBlue = Color(hex: "#056DFC")
    
    public func getColors(colorType: CustomColors) -> [Color] {
        switch colorType {
        case .Blue:
            return [.blueTop, .blueBottom]
        case .BlueNeil:
            return [.blueNeilTop, .blueNeilBottom]
        case .Red:
            return [.redTop, .redBottom]
        case .RedNeil:
            return [.redNeilTop, .redNeilBottom]
        case .Yellow:
            return [.yellowTop, .yellowBottom]
        case .Green:
            return [.greenTop, .greenBottom]
        case .Orange:
            return [.orangeTop, .orangeBottom]
        case .AquaGreen:
            return [.aquaGreenTop, .aquaGreenBottom]
        case .LightBlue:
            return [.lightBlueTop, .lightBlueBottom]
        case .Purple:
            return [.purpleTop, .purpleBottom]
        case .Pink:
            return [.pinkTop, .pinkBottom]
        case .Metal:
            return [.metalTop, .metalBottom]
        case .GreenNeil:
            return [.greenNeilTop, .greenNeilBottom]
        case .MetalGreen:
            return [.metalGreenTop, .metalGreenBottom]
        case .Lemon:
            return [.lemonTop, .lemonBottom]
        case .AlmostBlack:
            return [.almostBlackTop, .almostBlackBottom]
        case .Noir:
            return [.noir, .noir]
        case .White:
            return [.white, .white]
        }
        
    }
    
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
