//
//  Color.swift
//  CloneApp_Toss
//
//  Created by 김예훈 on 2022/07/02.
//

import Foundation
import UIKit

extension UIColor {
    static let theme = TossTheme()
}

struct TossTheme {
    let blue = UIColor(named: "TossBlue")!
    let background = UIColor(named: "TossBackground")!
    let groupedBackground = UIColor(named: "TossGroupedBackground")!
    let secondary = UIColor(named: "TossSecondary")!
    let tertiary = UIColor(named: "TossTertiary")!
}
