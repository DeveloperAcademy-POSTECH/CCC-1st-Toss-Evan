//
//  AuthViewController.swift
//  CloneApp_Toss
//
//  Created by 김예훈 on 2022/07/04.
//

import UIKit
import SnapKit

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        let blurBackground = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        let overlay = UIView(frame: .zero)
        overlay.backgroundColor = .systemIndigo.withAlphaComponent(0.2)
        view.addSubview(blurBackground)
        view.addSubview(overlay)
        blurBackground.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        overlay.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
