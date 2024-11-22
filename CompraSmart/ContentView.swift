//
//  ContentView.swift
//  CompraSmart
//
//  Created by MacOsX on 9/16/24.
//

import SwiftUI

// Extensión para UIColor
extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red, green, blue: CGFloat

        switch hexSanitized.count {
        case 3: // RGB
            red = CGFloat((rgb >> 8) & 0xF00) / 0xF00
            green = CGFloat((rgb >> 4) & 0xF0) / 0xF0
            blue = CGFloat(rgb & 0xF) / 0xF
        case 6: // RRGGBB
            red = CGFloat((rgb >> 16) & 0xFF) / 0xFF
            green = CGFloat((rgb >> 8) & 0xFF) / 0xFF
            blue = CGFloat(rgb & 0xFF) / 0xFF
        default:
            return nil
        }

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

struct ContentView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack{
            Login(authenticationViewModel: authenticationViewModel);
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(authenticationViewModel: AuthenticationViewModel())
    }
}
