//
//  Data.swift
//  CloneApp_Toss
//
//  Created by 김예훈 on 2022/07/02.
//

import UIKit

enum Item: Hashable {
    case asset(AssetInfo)
    case merchandise(MerchandiseInfo)
}

struct AssetInfo: Hashable {
    var name: String
    var amount: Int
    var canRemit: Bool
    var icon: UIImage
    private let identifier = UUID()
}

extension AssetInfo {
    static let samples = [
        AssetInfo(name: "토스뱅크 통장", amount: 23100, canRemit: true, icon: .assetIcon.toss),
        AssetInfo(name: "KB나라사랑우대통장", amount: 10030, canRemit: true, icon: .assetIcon.kb),
        AssetInfo(name: "입출금통장", amount: 1293000, canRemit: true, icon: .assetIcon.kakao),
        AssetInfo(name: "보통예금(IBK나라사랑통장)", amount: 3000, canRemit: true, icon: .assetIcon.ibk),
        AssetInfo(name: "세이프박스", amount: 0, canRemit: false, icon: .assetIcon.kakao),
        AssetInfo(name: "토스뱅크 돈 모으기", amount: 1000000, canRemit: false, icon: .assetIcon.toss),
        AssetInfo(name: "현대카드", amount: 4860, canRemit: true, icon: .assetIcon.hyndai)
    ]
    
    static let consumeSample = AssetInfo(name: "이번 달 쓴 금액", amount: 30140, canRemit: true, icon: .assetIcon.card)
}

struct MerchandiseInfo: Hashable {
    var subtitle: String
    var title: String
    var icon: UIImage
    private let identifier = UUID()
}

extension MerchandiseInfo {
    static let samples = [
        MerchandiseInfo(subtitle: "1분 만에", title: "신용 점수\n올리기", icon: .assetIcon.beliefUp),
        MerchandiseInfo(subtitle: "안전하게", title: "신용점수\n보기", icon: .assetIcon.beliefView),
        MerchandiseInfo(subtitle: "최근", title: "캐시백\n받기", icon: .assetIcon.cashback),
        MerchandiseInfo(subtitle: "인기", title: "더보기", icon: .assetIcon.more)
    ]
}
