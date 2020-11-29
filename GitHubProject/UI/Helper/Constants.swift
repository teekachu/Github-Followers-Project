//
//  Constants.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/20/20.
//

import Foundation
import UIKit

enum SFSymbols{
    
    static let location = "mappin.and.ellipse"
    static let repos = "folder"
    static let gists = "text.alignleft"
    static let follwers = "heart"
    static let following = "person.2"
}

//
enum ScreenSize {
    
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceTypes {
    
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale

    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}


struct Colors {
    static var darkGrey304057: UIColor = #colorLiteral(red: 0.1882352941, green: 0.2509803922, blue: 0.3411764706, alpha: 1)
    
    static let peachyda5e5a: UIColor = #colorLiteral(red: 0.8549019608, green: 0.368627451, blue: 0.3529411765, alpha: 1)
    
    static let orangee2814d: UIColor = #colorLiteral(red: 0.8862745098, green: 0.5058823529, blue: 0.3019607843, alpha: 1)
    
    static let yellowfdb903: UIColor = #colorLiteral(red: 0.9921568627, green: 0.7254901961, blue: 0.01176470588, alpha: 1)
    
    static let mediumBlueColor: UIColor = #colorLiteral(red: 0.7215686275, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
    
    static let mintBlueColor: UIColor = #colorLiteral(red: 0.9333333333, green: 0.9607843137, blue: 0.8588235294, alpha: 1)
}
