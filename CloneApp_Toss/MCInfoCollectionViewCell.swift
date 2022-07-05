//
//  MCInfoCollectionViewCell.swift
//  CloneApp_Toss
//
//  Created by 김예훈 on 2022/07/03.
//

import UIKit

class MCInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "MCInfoCollectionViewCell"
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 6
        return stackView
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(for: .footnote, weight: .semibold)
        label.textColor = .theme.lightGray
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(for: .headline, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .theme.darkGray
        return label
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
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
    
    func configureCell(data: MerchandiseInfo? = nil) {
        [subTitleLabel, titleLabel].forEach { stackView.addArrangedSubview($0) }
        [stackView, logoImageView].forEach { addSubview($0) }
            
        logoImageView.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
            $0.height.equalToSuperview().multipliedBy(0.25)
            $0.width.equalTo(logoImageView.snp.height)
        }
        
        stackView.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(16)
        }
        
        self.backgroundColor = .theme.groupedBackground
        self.layer.cornerRadius = 24
        
        if let data = data {
            updateCell(data: data)
        }
    }
    
    func updateCell(data: MerchandiseInfo) {
        subTitleLabel.text = data.subtitle
        titleLabel.text = data.title
        logoImageView.image = data.icon
    }

}
