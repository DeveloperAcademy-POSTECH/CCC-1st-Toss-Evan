//
//  AssetInfoCollectionViewCell.swift
//  CloneApp_Toss
//
//  Created by 김예훈 on 2022/07/02.
//

import UIKit
import SnapKit

class AssetInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "AssetInfoCollectionViewCell"
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 6
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(for: .footnote, weight: .semibold)
        label.textColor = .theme.lightGray
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(for: .headline, weight: .semibold)
        label.textColor = .theme.darkGray
        return label
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var remitButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("송금", for: .normal)
        button.setTitleColor(.theme.lightGray, for: .normal)
        button.titleLabel?.font = .preferredFont(for: .footnote, weight: .semibold)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.backgroundColor = .theme.tertiary
        button.layer.cornerRadius = 6
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = .black
            } else {
                backgroundColor = .theme.groupedBackground
            }
        }
    }
    
    func configureCell(data: AssetInfo? = nil) {
        [nameLabel, amountLabel].forEach { stackView.addArrangedSubview($0) }
        [stackView, logoImageView, remitButton].forEach { addSubview($0) }
            
        logoImageView.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalToSuperview().multipliedBy(0.5)
            $0.width.equalTo(logoImageView.snp.height)
            $0.centerY.equalToSuperview()
        }
        
        stackView.snp.makeConstraints{
            $0.leading.equalTo(logoImageView.snp.trailing).inset(-12)
            $0.centerY.equalToSuperview()
        }
        
        remitButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        if let data = data {
            updateCell(data: data)
        }
    }
    
    func updateCell(data: AssetInfo) {
        nameLabel.text = data.name
        amountLabel.text = "\(data.amount) 원"
        logoImageView.image = data.icon
        remitButton.isHidden = !data.canRemit
    }
}
