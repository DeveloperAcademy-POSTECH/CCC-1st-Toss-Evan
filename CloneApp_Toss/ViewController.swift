//
//  ViewController.swift
//  CloneApp_Toss
//
//  Created by 김예훈 on 2022/07/01.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .theme.background
        configureNavbar()
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
}
