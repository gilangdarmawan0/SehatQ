//
//  Style.swift
//  SehatQ
//
//  Created by Gilang Darmawan on 27/04/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import UIKit

enum FontType {
    static let regular         = "Poppins-Regular"
    static let bold            = "Poppins-Bold"
    static let semiBold        = "Poppins-SemiBold"
    static let medium          = "Poppins-Medium"
}

enum FontSize {
    static let XS       = CGFloat(11.0)
    static let XS12     = CGFloat(12.0)
    static let S        = CGFloat(13.0)
    static let SM       = CGFloat(14.0)
    static let M        = CGFloat(15.0)
    static let L        = CGFloat(18.0)
    static let XL       = CGFloat(21.0)
    static let XL22     = CGFloat(22.0)
    static let XL24     = CGFloat(24.0)
}

enum Alpha {
    static let none     = CGFloat(0.0)
    static let veryLow  = CGFloat(0.05)
    static let low      = CGFloat(0.30)
    static let medium1  = CGFloat(0.40)
    static let medium2  = CGFloat(0.50)
    static let medium3  = CGFloat(0.60)
    static let high     = CGFloat(0.87)
    static let full     = CGFloat(1.0)
}

enum Font {
    static func withSize(_ size: CGFloat, weight: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight(rawValue: weight))
    }
    
    static func willUse(name : String, size: CGFloat) -> UIFont {
        return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight(rawValue: UIFont.Weight.regular.rawValue))
    }
}

extension TextStyle {
    
    static let titleBold = TextStyle(
        font: Font.willUse(name: FontType.bold, size: FontSize.L),
        color: .gunmetal
    )

    static let titleBGunmetal15 = TextStyle(
        font: Font.willUse(name: FontType.bold, size: FontSize.M),
        color: .gunmetal
    )

    static let titleSBBrownishGreyTwo14 = TextStyle(
        font: Font.willUse(name: FontType.bold, size: FontSize.SM),
        color: .brownishGreyTwo
    )

    static let titleBBrownishGrey22 = TextStyle(
        font: Font.willUse(name: FontType.bold, size: FontSize.XL22),
        color: .brownishGreyTwo
    )

    static let textRegular = TextStyle(
        font: Font.willUse(name: FontType.regular, size: FontSize.S),
        color: .brownishGrey
    )

    static let textRegular11 = TextStyle(
        font: Font.willUse(name: FontType.regular, size: FontSize.XS),
        color: .brownishGrey
    )

    static let textMedium14 = TextStyle(
        font: Font.willUse(name: FontType.medium, size: FontSize.SM),
        color: .brownishGrey
    )

    static let textRegular12 = TextStyle(
        font: Font.willUse(name: FontType.regular, size: FontSize.XS12),
        color: .brownishGrey
    )

    static let textRBlue14 = TextStyle(
        font: Font.willUse(name: FontType.regular, size: FontSize.SM),
        color: .blue
    )

    static let textSBBrownishGrey13 = TextStyle(
        font: Font.willUse(name: FontType.semiBold, size: FontSize.S),
        color: .brownishGrey
    )

    static let textSBBrownishGrey14 = TextStyle(
        font: Font.willUse(name: FontType.semiBold, size: FontSize.SM),
        color: .brownishGrey
    )

    static let textSBBrownishGrayTwo24 = TextStyle(
        font: Font.willUse(name: FontType.semiBold, size: FontSize.XL24),
        color: .brownishGreyTwo
    )

    static let textMedium = TextStyle(
        font: Font.willUse(name: FontType.bold, size: FontSize.M),
        color: .brownishGrey
    )

    static let labelDarkishBlue = TextStyle(
        font: Font.willUse(name: FontType.semiBold, size: FontSize.SM),
        color: .darkishBlue
    )

    static let labelWhite = TextStyle(
        font: Font.willUse(name: FontType.semiBold, size: FontSize.SM),
        color: .pureWhite
    )

    static let labelRWhite12 = TextStyle(
        font: Font.willUse(name: FontType.semiBold, size: FontSize.XS12),
        color: .white
    )

    static let labelRDarkishBlue12 = TextStyle(
        font: Font.willUse(name: FontType.semiBold, size: FontSize.XS12),
        color: .darkishBlue
    )

    static let body = TextStyle(
        font: Font.withSize(15.0, weight: UIFont.Weight.regular.rawValue),
        color: .black
    )
    
    static let title = TextStyle(
        font: Font.withSize(20.0, weight: UIFont.Weight.light.rawValue),
        color: .black
    )
}

extension TextStyle {
    
    enum Button {
        static let action = TextStyle(
            font: Font.withSize(16.0, weight: UIFont.Weight.medium.rawValue),
            color: .blueyGrey
        )
    }
}

extension ViewStyle {
    enum Button {
        static let action = ViewStyle(
            backgroundColor : UIColor.darkishBlue,
            alpha: .none,
            tintColor: UIColor.clear,
            layerStyle: ViewStyle.LayerStyle(
                cornerRadius: 5.0,
                borderStyle: ViewStyle.LayerStyle.BorderStyle(
                    color: UIColor.gray,
                    width: 1.0
                ),
                shadowStyle: .none
            )
        )
        
        static let disable = ViewStyle(
            backgroundColor : UIColor.blue,
            alpha: Alpha.medium2,
            tintColor: UIColor.clear,
            layerStyle: ViewStyle.LayerStyle(
                cornerRadius: 5.0,
                borderStyle: ViewStyle.LayerStyle.BorderStyle(
                    color: UIColor.gray,
                    width: 1.0
                ),
                shadowStyle: .none
            )
        )
        
        static let main = ViewStyle(
            backgroundColor : .darkishBlue,
            alpha: .none,
            tintColor: .pureWhite,
            layerStyle: ViewStyle.LayerStyle(
                cornerRadius: 5.0,
                borderStyle: ViewStyle.LayerStyle.BorderStyle(
                    color: .darkishBlue,
                    width: 1.0
                ),
                shadowStyle: .none
            )
        )

        static let mainToolbar = ViewStyle(
            backgroundColor : .steelGrey,
            alpha: .none,
            tintColor: .pureWhite,
            layerStyle: ViewStyle.LayerStyle(
                cornerRadius: 0.0,
                borderStyle: ViewStyle.LayerStyle.BorderStyle(
                    color: .steelGrey,
                    width: 1.0
                ),
                shadowStyle: .none
            )
        )

        static let mainWhite = ViewStyle(
            backgroundColor : .pureWhite,
            alpha: .none,
            tintColor: .darkishBlue,
            layerStyle: ViewStyle.LayerStyle(
                cornerRadius: 5.0,
                borderStyle: ViewStyle.LayerStyle.BorderStyle(
                    color: .darkishBlue,
                    width: 1.0
                ),
                shadowStyle: .none
            )
        )

        static let mainDisabled = ViewStyle(
            backgroundColor : .inactiveButton,
            alpha: .none,
            tintColor: .pureWhite,
            layerStyle: ViewStyle.LayerStyle(
                cornerRadius: 5.0,
                borderStyle: ViewStyle.LayerStyle.BorderStyle(
                    color: .clear,
                    width: 0.0
                ),
                shadowStyle: .none
            )
        )
        
        static let outline = ViewStyle(
            backgroundColor : UIColor.clear,
            alpha: .none,
            tintColor: .darkishBlue,
            layerStyle: ViewStyle.LayerStyle(
                cornerRadius: 5.0,
                borderStyle: ViewStyle.LayerStyle.BorderStyle(
                    color: .darkishBlue,
                    width: 1.2
                ),
                shadowStyle: .none
            )
        )
        
        static let outlineDisabled = ViewStyle(
            backgroundColor : UIColor.clear,
            alpha: .none,
            tintColor: .blueyGrey,
            layerStyle: ViewStyle.LayerStyle(
                cornerRadius: 5.0,
                borderStyle: ViewStyle.LayerStyle.BorderStyle(
                    color: .blueyGrey,
                    width: 1.0
                ),
                shadowStyle: .none
            )
        )
    }
    
    enum View {
        static let floating = ViewStyle(
            backgroundColor : .pureWhite,
            alpha: .none,
            tintColor: UIColor.clear,
            layerStyle: ViewStyle.LayerStyle(
                cornerRadius: 0.0,
                borderStyle: ViewStyle.LayerStyle.BorderStyle(
                    color: .clear,
                    width: 0.0
                ),
                shadowStyle: ViewStyle.LayerStyle.ShadowStyle(
                    color: .black,
                    radius: 10.0,
                    offset: CGSize(width: 5, height: 5),
                    opacity: 0.5
                )
            )
        )
        
        static let floatingLow = ViewStyle(
            backgroundColor : .pureWhite,
            alpha: .none,
            tintColor: UIColor.clear,
            layerStyle: ViewStyle.LayerStyle(
                cornerRadius: 5.0,
                borderStyle: ViewStyle.LayerStyle.BorderStyle(
                    color: .clear,
                    width: 0.0
                ),
                shadowStyle: ViewStyle.LayerStyle.ShadowStyle(
                    color: .black,
                    radius: 5.0,
                    offset: CGSize(width: 2, height: 2),
                    opacity: 0.1
                )
            )
        )
    }
}

extension UIColor {
  @nonobjc class var gunmetal: UIColor {
    return UIColor(red: 74.0 / 255.0, green: 81.0 / 255.0, blue: 90.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var blueyGrey: UIColor {
    return UIColor(red: 148.0 / 255.0, green: 149.0 / 255.0, blue: 158.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var pureWhite: UIColor {
    return UIColor(white: 1.0, alpha: 1.0)
  }
  @nonobjc class var inactiveButton: UIColor {
    return UIColor(red: 196.0 / 255.0, green: 204.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var slightBlue: UIColor {
    return UIColor(red: 245.0 / 255.0, green: 248.0 / 255.0, blue: 1.0, alpha: 1.0)
  }
  @nonobjc class var colorRedMagentaRed: UIColor {
    return UIColor(red: 228.0 / 255.0, green: 35.0 / 255.0, blue: 84.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var seaBreeze: UIColor {
    return UIColor(red: 58.0 / 255.0, green: 159.0 / 255.0, blue: 215.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var inactiveText: UIColor {
    return UIColor(red: 110.0 / 255.0, green: 123.0 / 255.0, blue: 139.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var colorBlueLightBlue: UIColor {
    return UIColor(red: 191.0 / 255.0, green: 219.0 / 255.0, blue: 1.0, alpha: 1.0)
  }
  @nonobjc class var colorGreyPaleGrey: UIColor {
    return UIColor(white: 211.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var colorGreenFreshGreen: UIColor {
    return UIColor(red: 186.0 / 255.0, green: 202.0 / 255.0, blue: 28.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var colorOrangeBrightOrange: UIColor {
    return UIColor(red: 250.0 / 255.0, green: 189.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var darkishBlue: UIColor {
    return UIColor(red: 1.0 / 255.0, green: 70.0 / 255.0, blue: 160.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var brownishGrey: UIColor {
    return UIColor(white: 102.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var warmGrey: UIColor {
    return UIColor(white: 155.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var blue: UIColor {
    return UIColor(red: 0.0, green: 66.0 / 255.0, blue: 189.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var brownishGreyTwo: UIColor {
    return UIColor(white: 92.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var blueBlue: UIColor {
    return UIColor(red: 23.0 / 255.0, green: 45.0 / 255.0, blue: 202.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var lemon: UIColor {
    return UIColor(red: 1.0, green: 238.0 / 255.0, blue: 88.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var greyish: UIColor {
    return UIColor(white: 166.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var steelGrey: UIColor {
    return UIColor(red: 136.0 / 255.0, green: 137.0 / 255.0, blue: 138.0 / 255.0, alpha: 1.0)
  }
}
