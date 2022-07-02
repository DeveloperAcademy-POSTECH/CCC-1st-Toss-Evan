//
//  ViewController.swift
//  CloneApp_Toss
//
//  Created by 김예훈 on 2022/07/01.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var samples = AssetInfo.samples
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .theme.groupedBackground
        
        collectionView.register(
            AssetInfoCollectionViewCell.self,
            forCellWithReuseIdentifier: AssetInfoCollectionViewCell.identifier
        )
        
        return collectionView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .theme.background
        configureNavbar()
        configureTabBar()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(samples.count * 80 + 32)
        }
        collectionView.layer.cornerRadius = 20
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssetInfoCollectionViewCell.identifier, for: indexPath) as! AssetInfoCollectionViewCell

        cell.configureCell(data: samples[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 48, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
}

extension ViewController {
    private func configureNavbar() {
        
        // Left
        let iconButton = UIButton(type: .custom)
        iconButton.setImage(.icon.logo, for: .normal)
        iconButton.snp.makeConstraints {
            $0.width.equalTo(83)
            $0.height.equalTo(22)
        }
        iconButton.imageView?.contentMode = .scaleAspectFit
        let leftStackView = UIStackView(arrangedSubviews: [iconButton])
        leftStackView.isLayoutMarginsRelativeArrangement = true
        leftStackView.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        let iconBarItem = UIBarButtonItem(customView: leftStackView)
        self.navigationItem.leftBarButtonItem = iconBarItem
        
        // Right
        let talkButton = UIButton(type: .custom)
        talkButton.setImage(.icon.talk, for: .normal)
        talkButton.snp.makeConstraints {
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        talkButton.imageView?.contentMode = .scaleAspectFit
        
        let notiButton = UIButton(type: .custom)
        notiButton.setImage(.icon.ball, for: .normal)
        notiButton.snp.makeConstraints {
            $0.width.equalTo(19)
            $0.height.equalTo(21)
        }
        notiButton.imageView?.contentMode = .scaleAspectFit
        
        let plusButton = UIButton(type: .custom)
        plusButton.setImage(.icon.plus, for: .normal)
        
        let stackView = UIStackView(arrangedSubviews: [plusButton, talkButton, notiButton])
        stackView.axis = .horizontal
        stackView.spacing = 28
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: stackView)
        ]
    }
    
    private func configureTabBar() {
        let stackView = UIStackView(arrangedSubviews: [])
        
        TabBarItem.allCases.forEach { item in
            
            let tabImage = UIImageView(image: item.image)
            tabImage.snp.makeConstraints {
                $0.width.equalTo(20)
                $0.height.equalTo(tabImage.snp.width)
            }
            tabImage.contentMode = .scaleAspectFit
            let tabLabel = UILabel(frame: .zero)
            tabLabel.text = item.name
            tabLabel.font = .preferredFont(for: .caption1, weight: .semibold)
            
            tabLabel.textColor = .theme.secondary
            
            let tabButton = UIStackView(arrangedSubviews: [tabImage, tabLabel])
            tabButton.axis = .vertical
            tabButton.alignment = .center
            tabButton.spacing = 4
            
            stackView.addArrangedSubview(tabButton)
        }
        
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 40, bottom: 0, right: 40)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .theme.groupedBackground
        stackView.layer.cornerRadius = 20
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}

enum TabBarItem: String, CaseIterable {
    case home
    case benefit
    case remit
    case stock
    case extra
    
    var name: String {
        switch self {
        case .home:
            return "홈"
        case .benefit:
            return "혜택"
        case .remit:
            return "송금"
        case .stock:
            return "주식"
        case .extra:
            return "전체"
        }
    }
    
    var image: UIImage {
        switch self {
        case .home:
            return UIImage(named: "Home")!
        case .benefit:
            return UIImage(named: "Benefit")!
        case .remit:
            return UIImage(named: "Remit")!
        case .stock:
            return UIImage(named: "Stock")!
        case .extra:
            return UIImage(named: "Hamburger")!
        }
    }
}
