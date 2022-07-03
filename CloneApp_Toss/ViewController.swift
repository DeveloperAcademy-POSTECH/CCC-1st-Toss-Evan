//
//  ViewController.swift
//  CloneApp_Toss
//
//  Created by 김예훈 on 2022/07/01.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    enum Section: Int, Hashable, CaseIterable, CustomStringConvertible {
        case tossBank, asset, consume, merchandise
        
        var description: String {
            switch self {
            case .tossBank:
                return "토스뱅크"
            case .asset:
                return "자산"
            case .consume:
                return "소비"
            case .merchandise:
                return "상품"
            }
        }
    }
    static let sectionHeaderElementKind = "section-header-element-kind"
    static let sectionCenterHeaderElementKind = "sectionCenter-header-element-kind"
    static let sectionFooterElementKind = "section-footer-element-kind"
    static let sectionBackgroundElementKind = "section-background-element-kind"
    
    var dataSource: UICollectionViewDiffableDataSource<Section, AssetInfo>! = nil
    
    var collectionView: UICollectionView!
    let stackView = UIStackView(arrangedSubviews: [])
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .theme.background
        configureNavbar()
        configureTabBar()
        configureHierarchy()
        view.bringSubviewToFront(stackView)
    }
}

extension ViewController: UICollectionViewDelegate {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 40, right: 0)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 20
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalTo(stackView.snp.top)
        }
        
        let cellRegistration = UICollectionView.CellRegistration<AssetInfoCollectionViewCell, AssetInfo> { (cell, indexPath, assetInfo) in
            cell.nameLabel.text = assetInfo.name
            cell.amountLabel.text = "\(assetInfo.amount)"
            cell.logoImageView.image = assetInfo.icon
            cell.remitButton.isHidden = !assetInfo.canRemit
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <TitleHeaderSupplementaryView>(elementKind: ViewController.sectionHeaderElementKind) {
            (supplementaryView, string, indexPath) in
            supplementaryView.label.text = Section(rawValue: indexPath.section)?.description
        }
        
        let headerCenterRegistration = UICollectionView.SupplementaryRegistration
        <TitleCenterSupplementaryView>(elementKind: ViewController.sectionCenterHeaderElementKind) {
            (supplementaryView, string, indexPath) in
            supplementaryView.label.text = Section(rawValue: indexPath.section)?.description
        }
        
        let footerRegistration = UICollectionView.SupplementaryRegistration
        <FooterSupplementaryView>(elementKind: ViewController.sectionFooterElementKind) {
            (supplementaryView, string, indexPath) in
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, AssetInfo>(collectionView: collectionView) { (collectionView, indexPath, item) -> AssetInfoCollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: index)
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            if kind == ViewController.sectionCenterHeaderElementKind {
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerCenterRegistration, for: index)
            } else if kind == ViewController.sectionHeaderElementKind {
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
            } else if kind == ViewController.sectionFooterElementKind {
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: index)
            }
            return nil
        }
        
//        let sections = Section.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, AssetInfo>()
        [Section.tossBank, Section.asset, Section.consume].forEach {
            snapshot.appendSections([$0])
            if $0 == .asset {
                snapshot.appendItems(AssetInfo.samples)
            } else if $0 == .consume {
                snapshot.appendItems([AssetInfo.consumeSample])
            }
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            
            let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(
                elementKind: ViewController.sectionBackgroundElementKind)
            sectionBackgroundDecoration.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16)
            section.decorationItems = [sectionBackgroundDecoration]
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: sectionIndex == 0 ? .estimated(72) : .estimated(60))
            
            let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .absolute(16))
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: sectionKind == .tossBank ? ViewController.sectionCenterHeaderElementKind : ViewController.sectionHeaderElementKind,
                alignment: .top)
            
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: footerSize,
                elementKind: ViewController.sectionFooterElementKind, alignment: .bottom)
            
            if sectionKind == .tossBank {
                section.boundarySupplementaryItems = [sectionHeader]
            } else if sectionKind != .merchandise {
                section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
            }
            
            return section
        }
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        layout.register(
            SectionBackgroundView.self,
            forDecorationViewOfKind: ViewController.sectionBackgroundElementKind)
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hi")
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
        stackView.layer.borderWidth = 0.6
        stackView.layer.borderColor = UIColor.theme.background.cgColor
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
