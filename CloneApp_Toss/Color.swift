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
}

struct TossColorTheme {
    let blue = UIColor(named: "TossBlue")!
    let background = UIColor(named: "TossBackground")!
    let groupedBackground = UIColor(named: "TossGroupedBackground")!
    let secondary = UIColor(named: "TossSecondary")!
    let tertiary = UIColor(named: "TossTertiary")!
}

struct TossImageTheme {
    let plus = UIImage(named: "Plus")!
    let ball = UIImage(named: "Noti")!
    let talk = UIImage(named: "Talk")!
}
