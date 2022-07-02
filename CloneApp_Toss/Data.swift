//
//  Data.swift
//  CloneApp_Toss
//
//  Created by 김예훈 on 2022/07/02.
//

import UIKit

struct AssetInfo {
    var name: String
    var amount: Int
    var canRemit: Bool
    var icon: UIImage
}

extension AssetInfo {
    static let samples = [
        AssetInfo(name: "토스뱅크 통장", amount: 231000, canRemit: true, icon: .assetIcon.toss),
        AssetInfo(name: "KB나라사랑우대통장", amount: 100300, canRemit: true, icon: .assetIcon.kb),
        AssetInfo(name: "입출금통장", amount: 1293000, canRemit: true, icon: .assetIcon.kakao),
        AssetInfo(name: "보통예금(IBK나라사랑통장)", amount: 3000, canRemit: true, icon: .assetIcon.ibk),
        AssetInfo(name: "세이프박스", amount: 0, canRemit: true, icon: .assetIcon.kakao),
        AssetInfo(name: "토스뱅크 돈 모으기", amount: 1000000, canRemit: true, icon: .assetIcon.toss),
        AssetInfo(name: "현대카드", amount: 4860, canRemit: true, icon: .assetIcon.hyndai)
    ]
}
