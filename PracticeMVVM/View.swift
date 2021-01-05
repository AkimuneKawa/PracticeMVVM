//
//  View.swift
//  PracticeMVVM
//
//  Created by 河明宗 on 2021/01/05.
//  Copyright © 2021 河明宗. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Then

final class ViewController: UIViewController {
    private let idTextField = UITextField().then {
        $0.backgroundColor = .gray
    }
    private let passwordTextField = UITextField().then {
        $0.backgroundColor = .gray
    }
    private let validationLabel = UILabel().then {
        $0.text = "aaaaaa"
    }
    
    private let model: ViewModel
    
    init(model: ViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(validationLabel)
    }
    
    private func setupConstraints() {
        idTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(32)
            $0.centerX.equalTo(idTextField.snp.centerX)
            $0.width.equalTo(200)
        }
        validationLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(32)
            $0.centerX.equalTo(idTextField.snp.centerX)
        }
    }
}
