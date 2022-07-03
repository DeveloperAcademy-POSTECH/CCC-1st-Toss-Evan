//
//  TitleSupplementaryView.swift
//  CloneApp_Toss
//
//  Created by 김예훈 on 2022/07/03.
//

import UIKit
import SnapKit

class TitleSupplementaryView: UICollectionReusableView {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .title2, weight: .bold)
        return label
    }()
    
    static let reuseIdentifier = "title-supplementary-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TitleSupplementaryView {
    func configure() {
        addSubview(label)
        label.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
}

