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
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    
    var webController = WebViewController()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 40, right: 0)
        collectionView.backgroundColor = .clear
        collectionView.refreshControl = refreshControl
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 20
        return collectionView
    }()
    
    lazy var stackView = UIStackView(arrangedSubviews: [])
    
    lazy var stickyFooter: UIView = {
        let stickyFooter = UIView(frame: .zero)
        let label = UILabel(frame: .zero)
        label.text = "소비"
        label.font = .preferredFont(for: .title2, weight: .bold)
        stickyFooter.addSubview(label)
        stickyFooter.backgroundColor = .theme.groupedBackground
        stickyFooter.layer.borderWidth = 0.6
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(40)
            $0.centerY.equalToSuperview()
        }
        
        return stickyFooter
    }()
    
    var isSticky: Bool = true {
        didSet {
            if isSticky {
                stickyFooter.isHidden = false
                stickyFooter.snp.remakeConstraints {
                    $0.height.equalTo(62)
                    $0.leading.equalToSuperview()
                    $0.trailing.equalToSuperview()
                    $0.bottom.equalTo(stackView.snp.top)
                }
                UIView.animate(withDuration: 0.2) {
                    self.stickyFooter.layoutIfNeeded()
                }
            } else {
                stickyFooter.isHidden = true
            }
        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl(frame: .zero)
        control.addTarget(self, action: #selector(endRefresh), for: .valueChanged)
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .theme.background
        configureNavbar()
        configureTabBar()
        configureHierarchy()
        view.addSubview(stickyFooter)
        view.bringSubviewToFront(stackView)
        stickyFooter.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(62)
            $0.bottom.equalTo(stackView.snp.top)
            $0.centerX.equalTo(stackView.snp.centerX)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        stickyFooter.layer.borderColor = UIColor.theme.background.cgColor
        stackView.layer.borderColor = UIColor.theme.background.cgColor
    }
    
    override func viewDidLayoutSubviews() {
        stickyFooter.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        stackView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
    }
}

extension ViewController: UICollectionViewDelegate {
    func configureHierarchy() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalTo(stackView.snp.top)
        }
        
        let cellRegistration = UICollectionView.CellRegistration<AssetInfoCollectionViewCell, Item> { (cell, indexPath, item) in
            if case Item.asset(let assetInfo) = item {
                cell.nameLabel.text = assetInfo.name
                cell.amountLabel.text = assetInfo.amount.decimalWon()
                cell.logoImageView.image = assetInfo.icon
                cell.remitButton.isHidden = !assetInfo.canRemit
            }
        }
        
        let mcCellRegistration = UICollectionView.CellRegistration<MCInfoCollectionViewCell, Item> { (cell, indexPath, item) in
            if case Item.merchandise(let merchandise) = item {
                cell.subTitleLabel.text = merchandise.subtitle
                cell.titleLabel.text = merchandise.title
                cell.logoImageView.image = merchandise.icon
            }
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
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            switch section {
            case .merchandise:
                return collectionView.dequeueConfiguredReusableCell(using: mcCellRegistration, for: indexPath, item: item)
            default:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
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
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        [Section.tossBank, Section.asset, Section.consume, Section.merchandise].forEach {
            snapshot.appendSections([$0])
            if $0 == .asset {
                snapshot.appendItems(AssetInfo.samples.map{ Item.asset($0) })
            } else if $0 == .consume {
                snapshot.appendItems([Item.asset(AssetInfo.consumeSample)])
            } else if $0 == .merchandise {
                snapshot.appendItems(MerchandiseInfo.samples.map{ Item.merchandise($0) })
            }
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            
            if sectionKind == .merchandise {
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalWidth(0.36))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 14
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                
                let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(
                    elementKind: ViewController.sectionBackgroundElementKind)
                sectionBackgroundDecoration.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16)
                section.decorationItems = [sectionBackgroundDecoration]
            }
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: sectionIndex == 0 ? .absolute(84) : .estimated(60))
            
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        print(scrollView.contentSize.height)
        
        if scrollView.contentOffset.y > 25.6 {
            isSticky = false
        } else {
            isSticky = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ItemViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
        iconButton.addTarget(self, action: #selector(presentWebView), for: .touchUpInside)
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
        stackView.layer.borderWidth = 0.6
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}

extension ViewController {
    
    @objc func endRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
    
    @objc func presentWebView() {
        present(webController, animated: true)
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
