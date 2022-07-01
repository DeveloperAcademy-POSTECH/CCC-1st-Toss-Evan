//
//  ViewController.swift
//  CloneApp_Toss
//
//  Created by 김예훈 on 2022/07/01.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .theme.background
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Toss", style: .plain, target: nil, action: #selector(test))
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: .icon.talk, style: .plain, target: nil, action: nil),
            UIBarButtonItem(image: .icon.ball, style: .plain, target: nil, action: nil),
        ]
    }
    
    @objc private func test() {
        
    }
}

