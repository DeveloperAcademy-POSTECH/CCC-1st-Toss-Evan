//
//  Color.swift
//  CloneApp_Toss
//
//  Created by 김예훈 on 2022/07/02.
//

import Foundation
import UIKit

extension UIColor {
    static let theme = TossColorTheme()
}

extension UIImage {
    static let icon = TossImageTheme()
    static let assetIcon = TossAssetImageTheme()
}

struct TossColorTheme {
    let blue = UIColor(named: "TossBlue")!
    let background = UIColor(named: "TossBackground")!
    let groupedBackground = UIColor(named: "TossGroupedBackground")!
    let secondary = UIColor(named: "TossSecondary")!
    let tertiary = UIColor(named: "TossTertiary")!
    let darkGray = UIColor(named: "TossDarkGray")!
    let lightGray = UIColor(named: "TossLightGray")!
}

struct TossImageTheme {
    let logo = UIImage(named: "Logo")!
    let plus = UIImage(named: "Plus")!
    let ball = UIImage(named: "Noti")!
    let talk = UIImage(named: "Talk")!
}

struct TossAssetImageTheme {
    let toss = UIImage(named: "Toss")!
    let kb = UIImage(named: "Kb")!
    let ibk = UIImage(named: "IBK")!
    let kakao = UIImage(named: "Kakao")!
    let collect = UIImage(named: "Toss")!
    let hyndai = UIImage(named: "Toss")!
}
