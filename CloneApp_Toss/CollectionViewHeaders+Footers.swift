//
//  TitleSupplementaryView.swift
//  CloneApp_Toss
//
//  Created by 김예훈 on 2022/07/03.
//

import UIKit
import SnapKit

class TitleHeaderSupplementaryView: UICollectionReusableView {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .title2, weight: .bold)
        return label
    }()
    
    lazy var chevron: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        
        let image = UIImage(systemName: "chevron.forward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold))!
        imageView.tintColor = .theme.secondary
        imageView.image = image
        
        return imageView
    }()
    
    static let reuseIdentifier = "titleHeader-supplementary-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TitleHeaderSupplementaryView {
    func configure() {
        [label, chevron].forEach{ addSubview($0) }
        
        label.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(8)
        }
        
        chevron.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalTo(label.snp.centerY)
        }
    }
}

class TitleCenterSupplementaryView: UICollectionReusableView {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .title2, weight: .bold)
        return label
    }()
    
    lazy var chevron: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        
        let image = UIImage(systemName: "chevron.forward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold))!
        imageView.tintColor = .theme.secondary
        imageView.image = image
            
        return imageView
    }()
    
    static let reuseIdentifier = "titleCenter-supplementary-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TitleCenterSupplementaryView {
    func configure() {
        [label, chevron].forEach{ addSubview($0) }

        label.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        chevron.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalTo(label.snp.centerY)
        }
    }
}

class FooterSupplementaryView: UICollectionReusableView {
    
    static let reuseIdentifier = "footer-supplementary-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
