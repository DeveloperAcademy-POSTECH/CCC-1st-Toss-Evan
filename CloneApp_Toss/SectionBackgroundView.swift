//
//  SectionBackgroundView.swift
//  CloneApp_Toss
//
//  Created by 김예훈 on 2022/07/03.
//

import UIKit

class SectionBackgroundView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
}

extension SectionBackgroundView {
    func configure() {
        backgroundColor = .theme.groupedBackground
        layer.cornerRadius = 20
    }
}
