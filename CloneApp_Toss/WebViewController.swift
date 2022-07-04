//
//  WebViewController.swift
//  CloneApp_Toss
//
//  Created by 김예훈 on 2022/07/04.
//

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    lazy var navBar: UIView = {
        let bar = UIView(frame: .zero)
        bar.backgroundColor = .theme.groupedBackground
        return bar
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        button.tintColor = .theme.secondary
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton(type: .custom)
        let label = UILabel(frame: .zero)
        button.setTitle("공유하기", for: .normal)
        button.titleLabel?.font = .preferredFont(for: .headline, weight: .semibold)
        button.tintColor = .white
        button.backgroundColor = .theme.blue
        button.layer.cornerRadius = 12
        return button
    }()
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://toss.im/about-free-transfer?is_retargeting=true&af_dp=servicetoss%3A%2F%2Fabout-free-transfer&c=conversion_transfer_performance&af_ad=155014&pid=referral&id=35776992-ec22-4462-b1f3-42c2106b714d&af_adset=transfer_20210906_seokju.me")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        configure()
    }
    
    private func configure() {
        navBar.addSubview(dismissButton)
        view.addSubview(navBar)
        view.addSubview(shareButton)
        navBar.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        dismissButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        shareButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(56)
            $0.bottom.equalTo(view.layoutMarginsGuide)
        }
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}
